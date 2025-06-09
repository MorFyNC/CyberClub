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
    // Обновление бронирований каждую минуту
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            using (var scope = _services.CreateScope())
            {
                try
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
                               (s.Reservations.FirstOrDefault().ReservationStatus != ReservationStatus.Finished &&
                               s.Reservations.FirstOrDefault().ReservationStatus != ReservationStatus.Cancelled))
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

                var workStationsToFree = await dbContext.WorkStations
                    .Include(x => x.Sessions)
                    .Where(x => x.IdStatus == WorkStationStatus.Busy && 
                    !x.Sessions.Any(a => a.StartTime <= DateTime.Now && 
                    a.StartTime.Value.AddHours(a.HoursCount.Value) >= DateTime.Now ))
                    .ToListAsync();

                foreach(var workStation in workStationsToFree)
                {
                    workStation.IdStatus = WorkStationStatus.Free;
                }

                var workStationsToBusy = await dbContext.WorkStations
                    .Include(x => x.Sessions)
                    .Where(x => x.IdStatus == WorkStationStatus.Free &&
                   x.Sessions.Any(a => a.StartTime <= DateTime.Now && a.StartTime.Value.AddHours(a.HoursCount.Value) >= DateTime.Now))
                    .ToListAsync();

                foreach (var workstation in workStationsToBusy)
                {
                    workstation.IdStatus = WorkStationStatus.Busy;
                }

                if (reservationsToActivate.Any() || reservationsToCancel.Any() || endedSessions.Any() || workStationsToFree.Any() || workStationsToBusy.Any())
                {
                    await dbContext.SaveChangesAsync(stoppingToken);
                }

                
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }

            await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
        }
    }
}
