using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.Repositories.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.GeneralManagement
{
    public class WorkinPointService : IWorkinPointService
    {
        WorkinPointRepository repo = null;
        public WorkinPointService()
        {
            repo = new WorkinPointRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public WorkingPoints GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<WorkingPoints> List()
        {
            return repo.List();
        }

        public IEnumerable<WorkingPoints> ListActive()
        {
            throw new NotImplementedException();
        }

        public DbResult Update(WorkingPoints entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
