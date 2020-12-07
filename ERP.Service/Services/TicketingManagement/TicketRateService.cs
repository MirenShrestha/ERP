using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.Repositories.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;

namespace ERP.Service.Services.TicketingManagement
{
    public class TicketRateService : ITicketRateService
    {
        TicketRateRepository repo = null;
        public TicketRateService()
        {
            repo = new TicketRateRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public TicketRate GetById(string id)
        {
            return repo.GetById(id);
        }

        public List<TicketRateVM> List(bool Active = false)
        {
            return repo.List();
        }

        public IEnumerable<TicketRate> List()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TicketRate> ListActive()
        {
            throw new NotImplementedException();
        }

        public DbResult Update(TicketRate entity, string flag)
        {
            return repo.Update(entity, flag);
        }
    }
}
