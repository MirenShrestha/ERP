
namespace ERP.Core.Models.UserManagement
{
   public class ViewModelRole:BaseModel
    {
        public string RoleId { get; set; }
        public string RoleName { get; set; }
        public bool IsAssigned { get; set; }
    }
}
