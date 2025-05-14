using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class Membership
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public int? HoursCount { get; set; }

    public decimal? Price { get; set; }

    public virtual ICollection<MembershipBuy> MembershipBuys { get; set; } = new List<MembershipBuy>();
}
