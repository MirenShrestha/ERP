using ERP.Core.Models;
using ERP.Core.Models.Common;
using ERP.Core.Models.UserManagement;
using System;
using System.Collections.Generic;
using System.Web;

namespace ERP.Service.Interfaces
{
    public interface ICommonLibraryService 
    {
        DbResult LogError(Exception lastError, string page, string errDetails, string referer = "");
        ViewModelUserInformation GetUserInformation();
        List<ApplicationLog> GetByParameters(string Code, string FromDate, string ToDate);
    }
}
