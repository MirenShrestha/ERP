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

    public class SettingsService : ISettingsService
    {
        SettingsRepository repo = null;

        public SettingsService()
        {
            repo = new SettingsRepository();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Settings GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Settings> List()
        {
            return repo.List();
        }

        public IEnumerable<Settings> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Settings entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
