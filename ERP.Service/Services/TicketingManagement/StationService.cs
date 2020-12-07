using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.Repositories.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.TicketingManagement
{
    
    public class StationService : IStationService
    {
        StationRepository repo = null;
        public StationService()
        {
            repo = new StationRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Station GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Station> List()
        {
            return repo.List();
        }

        public IEnumerable<Station> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Station entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
