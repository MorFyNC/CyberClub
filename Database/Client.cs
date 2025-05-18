using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class Client
{
    public int Id { get; set; }

    public int? IdUser { get; set; }

    public decimal? Balance { get; set; }

    public int? Bonuses { get; set; }

    public int? LoyalityLevel { get; set; }

    public virtual ICollection<BalanceReplenishment> BalanceReplenishments { get; set; } = new List<BalanceReplenishment>();

    public virtual ICollection<BonusMove> BonusMoves { get; set; } = new List<BonusMove>();

    public virtual User? IdUserNavigation { get; set; }

    public virtual LoyalityLevel? LoyalityLevelNavigation { get; set; }

    public virtual ICollection<MembershipBuy> MembershipBuys { get; set; } = new List<MembershipBuy>();

    public virtual ICollection<Session> Sessions { get; set; } = new List<Session>();
}
