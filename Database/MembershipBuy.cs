using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class MembershipBuy
{
    public int Id { get; set; }

    public int? IdClient { get; set; }

    public int? IdMembership { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<ClientsMembership> ClientsMemberships { get; set; } = new List<ClientsMembership>();

    public virtual Client? IdClientNavigation { get; set; }

    public virtual Membership? IdMembershipNavigation { get; set; }
}
