using System;
using System.Collections.Generic;

namespace CyberClub.Database;

public partial class User
{
    public int Id { get; set; }

    public string? Phone { get; set; }

    public string? Password { get; set; }

    public string? Fullname { get; set; }

    public DateOnly? BirthDate { get; set; }

    public DateTime? CreatedAt { get; set; }

    public string? Role { get; set; }

    public bool? RequireData { get; set; }

    public virtual ICollection<Client> Clients { get; set; } = new List<Client>();

    public virtual Role? RoleNavigation { get; set; }
}
