using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class WorkStationType
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<WorkStation> WorkStations { get; set; } = new List<WorkStation>();
}
