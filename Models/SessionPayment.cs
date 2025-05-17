using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class SessionPayment
{
    public int Id { get; set; }

    public int? BonusesSpent { get; set; }

    public decimal? TotalCost { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int? IdSession { get; set; }

    public int? HoursFromMembership { get; set; }

    public virtual Session? IdSessionNavigation { get; set; }
}
