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
    public class DeductionsService : IDeductionsService
    {
        DeductionsRepository repo = null;
        public DeductionsService()
        {
            repo = new DeductionsRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Deductions GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Deductions> List()
        {
            return repo.List();
        }

        public IEnumerable<Deductions> ListActive()
        {
            return repo.List();
        }

        public DbResult Update(Deductions entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
