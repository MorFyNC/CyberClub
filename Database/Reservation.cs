using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class Reservation
{
    public int Id { get; set; }

    public int? IdSession { get; set; }

    public int? ReservationStatus { get; set; }

    public bool? Confirmed { get; set; }

    public virtual Session? IdSessionNavigation { get; set; }

    public virtual ReservationStatus? ReservationStatusNavigation { get; set; }
}
