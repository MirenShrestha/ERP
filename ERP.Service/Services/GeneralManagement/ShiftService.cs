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
    public class ShiftService : IShiftService
    {
        ShiftRepository repo = null;
        public ShiftService()
        {
            repo = new ShiftRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Shift GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Shift> List()
        {
            return repo.List();
        }

        public IEnumerable<Shift> ListActive()
        {
            throw new NotImplementedException();
        }

        public DbResult Update(Shift entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
