using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class WorkStation
{
    public int Id { get; set; }

    public int? WorkStationType { get; set; }

    public int? IdStatus { get; set; }

    public bool? IsBlocked { get; set; }

    public decimal? Cost { get; set; }

    public string? Description { get; set; }

    public virtual WorkStationStatus? IdStatusNavigation { get; set; }

    public virtual ICollection<Session> Sessions { get; set; } = new List<Session>();

    public virtual WorkStationType? WorkStationTypeNavigation { get; set; }
}
