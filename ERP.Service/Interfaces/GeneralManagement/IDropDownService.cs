using ERP.Core.Models.GeneralManagement;
using System.Collections.Generic;

namespace ERP.Service.Interfaces.GeneralManagement
{
    public interface IDropDownService
    {
        List<DropDown> GetDropDowns(string flag, string SearchBy = "");
    }
}
