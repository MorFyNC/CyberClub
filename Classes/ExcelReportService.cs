namespace CyberClub.Classes
{
    using ClosedXML.Excel;
    using CyberClub.Database;
    using Microsoft.EntityFrameworkCore;
    using System.Data;

    public class ExcelReportService
    {
        private readonly BootcampContext _context;

        public ExcelReportService(BootcampContext context)
        {
            _context = context;
        }

        // Генерация статистики

        public async Task<byte[]> GenerateWorkstationUsageReport(DateTime? startDate, DateTime? endDate)
        {
            var sessions = await _context.Sessions
                .Include(s => s.IdWorkStationNavigation)
                .ThenInclude(w => w.WorkStationTypeNavigation)
                .Where(s =>
                    (startDate == null || s.StartTime >= startDate) &&
                    (endDate == null || s.StartTime <= endDate))
                .ToListAsync();

            var stats = sessions
                .GroupBy(s => new
                {
                    s.IdWorkStation,
                    StationType = s.IdWorkStationNavigation.WorkStationTypeNavigation.Name
                })
                .Select(g => new
                {
                    g.Key.IdWorkStation,
                    g.Key.StationType,
                    SessionCount = g.Count(),
                    TotalHours = g.Sum(s => s.HoursCount ?? 0)
                })
                .ToList();

            var totalSessions = stats.Sum(s => s.SessionCount);
            var totalHours = stats.Sum(s => s.TotalHours);

            using var workbook = new XLWorkbook();
            var worksheet = workbook.Worksheets.Add("Статистика станций");

            worksheet.Cell("A1").Value = "Отчет по использованию рабочих станций";
            worksheet.Range("A1:D1").Merge().Style.Font.Bold = true;

            if (startDate == null && endDate == null)
            {
                worksheet.Cell("A2").Value = "Период: за все время";
            }
            else if (startDate == null)
            {
                worksheet.Cell("A2").Value = $"Период: по {endDate:dd.MM.yyyy}";
            }
            else if (endDate == null)
            {
                worksheet.Cell("A2").Value = $"Период: с {startDate:dd.MM.yyyy}";
            }
            else
            {
                worksheet.Cell("A2").Value = $"Период: {startDate:dd.MM.yyyy}-{endDate:dd.MM.yyyy}";
            }
            worksheet.Range("A2:D2").Merge();

            var row = 4;
            worksheet.Cell(row, 1).Value = "ID станции";
            worksheet.Cell(row, 2).Value = "Тип станции";
            worksheet.Cell(row, 3).Value = "Кол-во сессий";
            worksheet.Cell(row, 4).Value = "Суммарное время (часы)";
            row++;

            foreach (var stat in stats)
            {
                worksheet.Cell(row, 1).Value = stat.IdWorkStation;
                worksheet.Cell(row, 2).Value = stat.StationType;
                worksheet.Cell(row, 3).Value = stat.SessionCount;
                worksheet.Cell(row, 4).Value = stat.TotalHours;
                row++;
            }

            // Итоговая строка
            worksheet.Cell(row, 2).Value = "Итого:";
            worksheet.Cell(row, 3).Value = totalSessions;
            worksheet.Cell(row, 4).Value = totalHours;

            worksheet.Range(row, 2, row, 4).Style.Font.Bold = true;
            worksheet.Range(row, 2, row, 4).Style.Fill.BackgroundColor = XLColor.LightGray;

            worksheet.Columns().AdjustToContents();
            worksheet.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            using var stream = new MemoryStream();
            workbook.SaveAs(stream);
            return stream.ToArray();
        }


        // Генерация финансового отчета
        public async Task<byte[]> GenerateFinancialReport(DateTime? startDate, DateTime? endDate)
        {
            var sessionPayments = await _context.SessionPayments
                .Include(sp => sp.IdSessionNavigation)
                .ThenInclude(r => r.Reservations)
                .Where(sp => (startDate == null || sp.CreatedAt >= startDate) && (endDate == null || sp.CreatedAt <= endDate) && sp.IdSessionNavigation.Reservations.FirstOrDefault().ReservationStatus != ReservationStatus.Cancelled)
                .ToListAsync();

            var membershipPurchases = await _context.MembershipBuys
                .Include(mb => mb.IdMembershipNavigation)
                .Where(sp => (startDate == null || sp.CreatedAt >= startDate) && (endDate == null || sp.CreatedAt <= endDate))
                .ToListAsync();

            var replenishments = await _context.BalanceReplenishments
                .Where(sp => (startDate == null || sp.CreatedAt >= startDate) && (endDate == null || sp.CreatedAt <= endDate))
                .ToListAsync();

            using var workbook = new XLWorkbook();
            var worksheet = workbook.Worksheets.Add("Финансовый отчет");

            worksheet.Cell("A1").Value = "Финансовый отчет компьютерного клуба";
            worksheet.Range("A1:D1").Merge().Style.Font.Bold = true;

            if(startDate == null && endDate == null)
            {
                worksheet.Cell("A2").Value = $"Период: за все время";
            }
            else if(startDate == null)
            {
                worksheet.Cell("A2").Value = $"Период: по {endDate:dd.MM.yyyy}";
            }
            else if(endDate == null)
            {
                worksheet.Cell("A2").Value = $"Период: с {startDate:dd.MM.yyyy}";
            }
            else
            {
                worksheet.Cell("A2").Value = $"Период: {startDate:dd.MM.yyyy}-{endDate:dd.MM.yyyy}";
            }

            worksheet.Range("A2:D2").Merge();


            var sessionsRow = 4;
            worksheet.Cell(sessionsRow, 1).Value = "Оплаты сессий";
            worksheet.Range(sessionsRow, 1, sessionsRow, 6).Merge().Style.Font.Bold = true;
            sessionsRow++;

            worksheet.Cell(sessionsRow, 1).Value = "ID";
            worksheet.Cell(sessionsRow, 2).Value = "Дата";
            worksheet.Cell(sessionsRow, 3).Value = "Сумма";
            worksheet.Cell(sessionsRow, 4).Value = "ID Сессии";
            worksheet.Cell(sessionsRow, 5).Value = "Часы по абонементу";
            worksheet.Cell(sessionsRow, 6).Value = "Дата сессии";
            sessionsRow++;

            foreach (var payment in sessionPayments)
            {
                worksheet.Cell(sessionsRow, 1).Value = payment.Id;
                worksheet.Cell(sessionsRow, 2).Value = payment.CreatedAt;
                worksheet.Cell(sessionsRow, 3).Value = payment.TotalCost;
                worksheet.Cell(sessionsRow, 4).Value = payment.IdSession;
                worksheet.Cell(sessionsRow, 5).Value = payment.HoursFromMembership;
                worksheet.Cell(sessionsRow, 6).Value = payment.IdSessionNavigation?.StartTime;
                sessionsRow++;
            }

            worksheet.Cell(sessionsRow, 2).Value = "Итого:";
            worksheet.Cell(sessionsRow, 3).Value = sessionPayments.Sum(sp => sp.TotalCost ?? 0);
            worksheet.Cell(sessionsRow, 3).Style.Font.Bold = true;
            sessionsRow += 2;

            worksheet.Cell(sessionsRow, 1).Value = "Продажи абонементов";
            worksheet.Range(sessionsRow, 1, sessionsRow, 5).Merge().Style.Font.Bold = true;
            sessionsRow++;

            worksheet.Cell(sessionsRow, 1).Value = "ID";
            worksheet.Cell(sessionsRow, 2).Value = "Дата";
            worksheet.Cell(sessionsRow, 3).Value = "Абонемент";
            worksheet.Cell(sessionsRow, 4).Value = "Часы";
            worksheet.Cell(sessionsRow, 5).Value = "Цена";
            sessionsRow++;

            foreach (var purchase in membershipPurchases)
            {
                worksheet.Cell(sessionsRow, 1).Value = purchase.Id;
                worksheet.Cell(sessionsRow, 2).Value = purchase.CreatedAt;
                worksheet.Cell(sessionsRow, 3).Value = purchase.IdMembershipNavigation?.Name;
                worksheet.Cell(sessionsRow, 4).Value = purchase.IdMembershipNavigation?.HoursCount;
                worksheet.Cell(sessionsRow, 5).Value = purchase.IdMembershipNavigation?.Price;
                sessionsRow++;
            }

            worksheet.Cell(sessionsRow, 2).Value = "Итого:";
            worksheet.Cell(sessionsRow, 5).Value = membershipPurchases.Sum(mb => mb.IdMembershipNavigation?.Price ?? 0);
            worksheet.Cell(sessionsRow, 5).Style.Font.Bold = true;
            sessionsRow += 2;

            worksheet.Cell(sessionsRow, 1).Value = "Пополнения баланса";
            worksheet.Range(sessionsRow, 1, sessionsRow, 4).Merge().Style.Font.Bold = true;
            sessionsRow++;

            worksheet.Cell(sessionsRow, 1).Value = "ID";
            worksheet.Cell(sessionsRow, 2).Value = "Дата";
            worksheet.Cell(sessionsRow, 3).Value = "ID Клиента";
            worksheet.Cell(sessionsRow, 4).Value = "Сумма";
            sessionsRow++;

            foreach (var replenishment in replenishments)
            {
                worksheet.Cell(sessionsRow, 1).Value = replenishment.Id;
                worksheet.Cell(sessionsRow, 2).Value = replenishment.CreatedAt;
                worksheet.Cell(sessionsRow, 3).Value = replenishment.IdClient;
                worksheet.Cell(sessionsRow, 4).Value = replenishment.Amount;
                sessionsRow++;
            }

            worksheet.Cell(sessionsRow, 2).Value = "Итого:";
            worksheet.Cell(sessionsRow, 4).Value = replenishments.Sum(r => r.Amount ?? 0);
            worksheet.Cell(sessionsRow, 4).Style.Font.Bold = true;

            var totalIncome = sessionPayments.Sum(sp => sp.TotalCost ?? 0) +
                            membershipPurchases.Sum(mb => mb.IdMembershipNavigation?.Price ?? 0) +
                            replenishments.Sum(r => r.Amount ?? 0);

            worksheet.Cell(sessionsRow + 2, 1).Value = "ОБЩИЙ ДОХОД:";
            worksheet.Cell(sessionsRow + 2, 2).Value = totalIncome;
            worksheet.Cell(sessionsRow + 2, 2).Style.Font.Bold = true;
            worksheet.Cell(sessionsRow + 2, 2).Style.Fill.BackgroundColor = XLColor.LightGreen;

            var workstationUsages = await _context.Sessions
                .Include(s => s.IdWorkStationNavigation)
                .ThenInclude(x => x.WorkStationTypeNavigation)
                .Where(s =>
                    (startDate == null || s.StartTime >= startDate) &&
                    (endDate == null || s.StartTime <= endDate))
                .ToListAsync();

            sessionsRow += 4;

            worksheet.Cell(sessionsRow, 1).Value = "Использование рабочих станций";
            worksheet.Range(sessionsRow, 1, sessionsRow, 4).Merge().Style.Font.Bold = true;
            sessionsRow++;

            worksheet.Cell(sessionsRow, 1).Value = "ID станции";
            worksheet.Cell(sessionsRow, 2).Value = "Тип станции";
            worksheet.Cell(sessionsRow, 3).Value = "Количество сессий";
            worksheet.Cell(sessionsRow, 4).Value = "Суммарное время (часы)";
            sessionsRow++;

            var workstationStats = workstationUsages
                .GroupBy(s => new { s.IdWorkStation, s.IdWorkStationNavigation.WorkStationTypeNavigation.Name })
                .Select(g => new
                {
                    WorkstationId = g.Key.IdWorkStation,
                    WorkstationName = g.Key.Name,
                    SessionCount = g.Count(),
                    TotalHours = g.Sum(s => s.HoursCount ?? 0)
                })
                .ToList();

            foreach (var stat in workstationStats)
            {
                worksheet.Cell(sessionsRow, 1).Value = stat.WorkstationId;
                worksheet.Cell(sessionsRow, 2).Value = stat.WorkstationName;
                worksheet.Cell(sessionsRow, 3).Value = stat.SessionCount;
                worksheet.Cell(sessionsRow, 4).Value = stat.TotalHours;
                sessionsRow++;
            }

            worksheet.Columns().AdjustToContents();
            worksheet.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            using var stream = new MemoryStream();
            workbook.SaveAs(stream);
            return stream.ToArray();
        }
    }
}
