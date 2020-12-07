using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.Repositories.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using System.Collections.Generic;

namespace ERP.Service.Services.GeneralManagement
{
    public class OrganisationService : IOrganistaionService
    {
        OrganisationRepository repo = null;
        public OrganisationService()
        {
            repo = new OrganisationRepository();
        }
        public DbResult Delete(string id)
        {
           return  repo.Delete(id);
        }

        public Organisation GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Organisation> List()
        {
            return repo.List();
        }

        public IEnumerable<Organisation> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Organisation entity, string flag)
        {
            return repo.Update(entity, flag);
        }
    }
}
