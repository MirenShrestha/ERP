using ERP.Core.Models;
using ERP.Core.Models.HRManagement;
using ERP.Data.Repositories.HRManagement;
using ERP.Service.Interfaces;
using ERP.Service.Interfaces.HRManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.HRManagement
{
    public class LeaveService : ILeaveService
    {
        LeaveRepository repo = null;
        public LeaveService()
        {
            repo = new LeaveRepository();
        }
        public List<LeaveApplicationVM> AllList()
        {
            return repo.AllList();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public LeaveApplication GetById(string id)
        {
            return repo.GetById(id);
        }

        public DbResult LeaveAction(string Id, string type)
        {
            return repo.LeaveAction(Id,type);
        }

        public IEnumerable<LeaveApplication> List()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<LeaveApplication> ListActive()
        {
            throw new NotImplementedException();
        }

        public DbResult Update(LeaveApplication entity, string flag)
        {
            return repo.Update(entity,flag);
        }

       
    }
}
