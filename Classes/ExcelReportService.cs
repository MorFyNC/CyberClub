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
        // Генерация отчета
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

            worksheet.Columns().AdjustToContents();
            worksheet.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

            using var stream = new MemoryStream();
            workbook.SaveAs(stream);
            return stream.ToArray();
        }
    }
}
