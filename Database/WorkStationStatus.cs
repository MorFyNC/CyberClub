using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class WorkStationStatus
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public bool? CanReserve { get; set; }

    public virtual ICollection<WorkStation> WorkStations { get; set; } = new List<WorkStation>();
}
