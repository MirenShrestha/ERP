using ERP.Core.Models.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using System.Collections.Generic;
using ERP.Data.Repositories.GeneralManagement;

namespace ERP.Service.Services.GeneralManagement
{
    public class DropDownService : IDropDownService
    {
        DropDownRepository repo = null;
        public DropDownService()
        {
            repo = new DropDownRepository();
        }
        public List<DropDown> GetDropDowns(string flag, string SearchBy = "")
        {
            return repo.GetDropDowns(flag, SearchBy);
        }

    }
}
