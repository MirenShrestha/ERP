using ERP.Core.Models;
using ERP.Core.Models.UserManagement;
using ERP.Data.Repositories.UserManagement;
using ERP.Service.Interfaces.UserManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.UserManagement
{
    public class RoleService : IRoleService
    {
        RoleRepository repo = null;
        public RoleService()
        {
            repo = new RoleRepository();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Role GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Role> List()
        {
            return repo.List();
        }

        public IEnumerable<Role> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Role entity, string flag)
        {
            return repo.Update(entity, flag);
        }

    }
}
