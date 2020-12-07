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
    public class FiscalYearService : IFiscalYearService
    {
        FiscalYearRepository repo = null;
        public FiscalYearService()
        {
            repo = new FiscalYearRepository();
        }
        public DbResult Delete(string id)
        {
          return  repo.Delete(id);
        }

        public FiscalYear GetById(string id)
        {
           return repo.GetById(id);
        }

        public IEnumerable<FiscalYear> List()
        {
            return repo.List();
        }

        public IEnumerable<FiscalYear> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(FiscalYear entity, string flag)
        {
            return repo.Update(entity, flag);
        }

    }
}
