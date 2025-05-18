using CyberClub.Database;
using Microsoft.EntityFrameworkCore;

namespace CyberClub.Classes
{
    public class UserService
    {
        public User CurrentUser { get; set; }
        public Client CurrentClient { get; set; }
        public bool IsAdmin { get; set; }

        public void Logout()
        {
            CurrentUser = null;
            CurrentClient = null;
            IsAdmin = false;
        }

        public async Task CheckLevel(Client client)
        {
            BootcampContext tempContext = new BootcampContext();

            var nextLevel = await tempContext.LoyalityLevels.Where(x => x.Id > client.LoyalityLevel).FirstOrDefaultAsync();

            if (nextLevel is null) return;

            var sessionCashPayments = await tempContext.Sessions
                    .Where(s => s.IdClient == client.Id)
                    .SelectMany(s => s.SessionPayments)
                    .Where(sp => sp.HoursFromMembership == null || sp.HoursFromMembership == 0)
                    .SumAsync(sp => sp.TotalCost ?? 0);

            var totalBonusesSpent = await tempContext.BonusMoves
                .Where(b => b.ClientId == client.Id && b.Amount < 0)
                .SumAsync(b => (int?)b.Amount) ?? 0;

            var membershipPayments = await tempContext.MembershipBuys
                .Where(mb => mb.IdClient == client.Id)
                .SumAsync(mb => mb.IdMembershipNavigation.Price ?? 0);

            var totalSpent = sessionCashPayments + membershipPayments - totalBonusesSpent;

            if(totalSpent >= nextLevel.RequiredSpend)
            {
                CurrentClient.LoyalityLevel = nextLevel.Id;
                await tempContext.SaveChangesAsync();
            }
        }
    }
}
