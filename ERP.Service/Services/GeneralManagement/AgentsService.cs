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
    public class AgentsService : IAgentsService
    {
        AgentsRepository repo = null;
        public AgentsService()
        {
            repo = new AgentsRepository();
        }
        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Agents GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Agents> List()
        {
            return repo.List();
        }

        public IEnumerable<Agents> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Agents entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
