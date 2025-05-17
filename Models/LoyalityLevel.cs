using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class LoyalityLevel
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public int? BonusIncrease { get; set; }

    public decimal? RequiredSpend { get; set; }

    public virtual ICollection<Client> Clients { get; set; } = new List<Client>();
}
