using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class Reservation
{
    public int Id { get; set; }

    public int? IdSession { get; set; }

    public int? ReservationStatus { get; set; }

    public virtual Session? IdSessionNavigation { get; set; }

    public virtual ReservationStatus? ReservationStatusNavigation { get; set; }
}
