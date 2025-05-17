using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class ReplenishmentType
{
    public int Id { get; set; }

    public string? TypeName { get; set; }

    public int? Comission { get; set; }

    public virtual ICollection<BalanceReplenishment> BalanceReplenishments { get; set; } = new List<BalanceReplenishment>();
}
