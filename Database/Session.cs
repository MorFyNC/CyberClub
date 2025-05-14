using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class Session
{
    public int Id { get; set; }

    public int? IdClient { get; set; }

    public int? IdWorkStation { get; set; }

    public DateTime? StartTime { get; set; }

    public int? HoursCount { get; set; }

    public virtual Client? IdClientNavigation { get; set; }

    public virtual WorkStation? IdWorkStationNavigation { get; set; }

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();

    public virtual ICollection<SessionPayment> SessionPayments { get; set; } = new List<SessionPayment>();
}
