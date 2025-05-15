using CyberClub.Database;

namespace CyberClub.Classes
{
    public class UserService
    {
        public User CurrentUser { get; set; }
        public Client CurrentClient { get; set; }
        public bool IsAdmin { get; set; }

        public void Logout()
        {
            CurrentUser = null;
            CurrentClient = null;
            IsAdmin = false;
        }
    }
}
