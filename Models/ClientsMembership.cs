using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class ClientsMembership
{
    public int Id { get; set; }

    public int? IdMembershipBuy { get; set; }

    public int? HoursLeft { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? Expires { get; set; }

    public bool? IsActive { get; set; }

    public virtual MembershipBuy? IdMembershipBuyNavigation { get; set; }
}
