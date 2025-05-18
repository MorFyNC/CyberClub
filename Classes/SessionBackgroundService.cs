using CyberClub.Database;
using Microsoft.EntityFrameworkCore;

public class SessionBackgroundService : BackgroundService
{
    private readonly IServiceProvider _services;
    private readonly ILogger<SessionBackgroundService> _logger;

    public SessionBackgroundService(IServiceProvider services, ILogger<SessionBackgroundService> logger)
    {
        _services = services;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            using (var scope = _services.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<BootcampContext>();

                var now = DateTime.Now;

                var reservationsToActivate = await dbContext.Reservations
                    .Include(r => r.IdSessionNavigation)
                    .ThenInclude(s => s.IdWorkStationNavigation)
                    .Where(r => r.ReservationStatus == ReservationStatus.Confirmed && 
                               r.IdSessionNavigation != null &&
                               r.IdSessionNavigation.StartTime <= now)
                    .ToListAsync(stoppingToken);

                foreach (var reservation in reservationsToActivate)
                {
                    reservation.ReservationStatus = ReservationStatus.Active; 
                    reservation.IdSessionNavigation.IdWorkStationNavigation.IdStatus = WorkStationStatus.Busy; 
                    _logger.LogInformation($"Резервация {reservation.Id} активирована");
                }

                var reservationsToCancel = await dbContext.Reservations
                    .Include(r => r.IdSessionNavigation)
                    .ThenInclude(s => s.IdWorkStationNavigation)
                    .Where(r => r.ReservationStatus == ReservationStatus.NotConfirmed && 
                               r.IdSessionNavigation != null &&
                               r.IdSessionNavigation.StartTime <= now)
                    .ToListAsync(stoppingToken);

                foreach (var reservation in reservationsToCancel)
                {
                    reservation.ReservationStatus = ReservationStatus.Cancelled;
                    reservation.IdSessionNavigation.IdWorkStationNavigation.IdStatus = WorkStationStatus.Free;
                    _logger.LogInformation($"Резервация {reservation.Id} отменена");
                }

                var endedSessions = await dbContext.Sessions
                    .Include(s => s.IdWorkStationNavigation)
                    .Include(s => s.Reservations)
                    .Where(s => s.StartTime.HasValue &&
                               s.HoursCount.HasValue &&
                               (s.StartTime.Value.AddHours(s.HoursCount.Value) <= now || s.Reservations.FirstOrDefault().ReservationStatus == ReservationStatus.Cancelled) &&
                               s.IdWorkStationNavigation != null &&
                               s.IdWorkStationNavigation.IdStatus == WorkStationStatus.Busy && 
                               s.Reservations.FirstOrDefault().ReservationStatus != ReservationStatus.Finished)
                                .ToListAsync(stoppingToken);

                foreach (var session in endedSessions)
                {
                    session.IdWorkStationNavigation.IdStatus = WorkStationStatus.Free;

                    var reservation = session.Reservations.FirstOrDefault();
                    if (reservation != null && reservation.ReservationStatus == ReservationStatus.Active)
                    {
                        reservation.ReservationStatus = ReservationStatus.Finished;
                    }

                    _logger.LogInformation($"Сессия {session.Id} завершена");
                }

                if (reservationsToActivate.Any() || reservationsToCancel.Any() || endedSessions.Any())
                {
                    await dbContext.SaveChangesAsync(stoppingToken);
                }
            }

            await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
        }
    }
}
