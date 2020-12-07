using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.Repositories.GeneralManagement;
using ERP.Service.Interfaces;
using ERP.Service.Interfaces.GeneralManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.GeneralManagement
{
    public class RoleManagementService : IRoleManagementService
    {
        RoleManagementRepository repo = null;
        public RoleManagementService()
        {
            repo = new RoleManagementRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public AspNetUserRoles GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<AspNetUserRoles> List()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<AspNetUserRoles> ListActive()
        {
            throw new NotImplementedException();
        }

        public List<AspNetUserRolesVM> ListAll(bool Active = false)
        {
            return repo.ListAll();
        }

        public DbResult Update(AspNetUserRoles entity, string flag)
        {
            return repo.Update(entity,flag);
        }

       
    }
}
