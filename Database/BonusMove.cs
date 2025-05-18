using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class BonusMove
{
    public int Id { get; set; }

    public int ClientId { get; set; }

    public int Amount { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual Client Client { get; set; } = null!;

    public virtual ICollection<SessionPayment> SessionPayments { get; set; } = new List<SessionPayment>();
}
