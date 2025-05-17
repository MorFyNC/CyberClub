using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class WorkStationStatus
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public bool? CanReserve { get; set; }

    public virtual ICollection<WorkStation> WorkStations { get; set; } = new List<WorkStation>();
}
