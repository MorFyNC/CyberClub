using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class ReservationStatus
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}
