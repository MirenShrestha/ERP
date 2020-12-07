using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.Repositories.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using System.Collections.Generic;

namespace ERP.Service.Services.GeneralManagement
{
    public class DepartmentService : IDepartmentService
    {
        DepartmentRepository repo = null;
        public DepartmentService()
        {
            repo = new DepartmentRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Department GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Department> List()
        {
            return repo.List();
        }

        public IEnumerable<Department> ListActive()
        {
            throw new System.NotImplementedException();
        }

        public DbResult Update(Department entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
