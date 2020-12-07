using ERP.Core.Models;
using ERP.Core.Models.UserManagement;
using System.Collections.Generic;

namespace ERP.Service.Interfaces.UserManagement
{
    
    public interface IUserService : IBaseService<User, string, DbResult>
    {
        // DbResult AssignRoles(string id, string roleIds);
        //List<ViewModelRole> GetRolesByUserId(string id);
        //DbResult AssignMenus(string userId, string functionIds);

        DbResult UpdateUser(Register obj);
    }
}
