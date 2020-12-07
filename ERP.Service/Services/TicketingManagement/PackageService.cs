using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.Repositories.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;

namespace ERP.Service.Services.TicketingManagement
{
    public class PackageService : IPackageService
    {
        PackageRepository repo;
        public PackageService()
        {
            repo = new PackageRepository();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Package GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Package> List()
        {
            return repo.List();
        }

        public IEnumerable<Package> ListActive()
        {
            throw new NotImplementedException();
        }

        public DbResult Update(Package entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
