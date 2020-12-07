using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.Repositories.GeneralManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.TicketingManagement
{
    public class DesignationService : IDesignationService
    {
        DesignationRepository repo = null;
        public DesignationService()
        {
            repo = new DesignationRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Designation GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Designation> List()
        {
            return repo.List();
        }

        public IEnumerable<Designation> ListActive()
        {
            return repo.List();
        }

        public DbResult Update(Designation entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
