using System;
using System.Collections.Generic;

namespace CyberClub.Models;

public partial class Role
{
    public string Role1 { get; set; } = null!;

    public string? Name { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
