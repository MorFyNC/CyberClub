using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class BalanceReplenishment
{
    public int Id { get; set; }

    public int? IdClient { get; set; }

    public decimal? Amount { get; set; }

    public int? ReplenishmentType { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Client? IdClientNavigation { get; set; }

    public virtual ReplenishmentType? ReplenishmentTypeNavigation { get; set; }
}
