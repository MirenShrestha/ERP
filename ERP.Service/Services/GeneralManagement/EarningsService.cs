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
    public class EarningsService : IEarningsService
    {
        EarningsRepository repo = null;
        public EarningsService()
        {
            repo = new EarningsRepository();
        }

        public DbResult Delete(string id)
        {
           return  repo.Delete(id);
        }

        public Earnings GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Earnings> List()
        {
            return repo.List();
        }

        public IEnumerable<Earnings> ListActive()
        {
            return repo.List();
        }

        public DbResult Update(Earnings entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
