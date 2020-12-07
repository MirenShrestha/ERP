using ERP.Data.Repositories;
using System;
using System.Collections.Generic;
using ERP.Core.Models;
using ERP.Core.Models.Common;
using ERP.Core.Models.UserManagement;
using ERP.Service.Interfaces;
using System.Web;

namespace ERP.Service.Services
{
    public class CommonLibraryService  : ICommonLibraryService
    {
        CommonLibraryRepository repo = null;
        public CommonLibraryService()
        {
            repo = new CommonLibraryRepository();
        }
        //public static DbResult LogError(Exception lastError, string page, string errorDetails, string referer = "")
        //{
        //    return CommonLibraryRepository.LogError(lastError, page, errorDetails, referer);
        //}

        //public static ViewModelUserInformation GetUserInformation()
        //{
        //    return CommonLibraryRepository.GetUserInformation();
        //}

        //public static List<ApplicationLog> GetByParameters(string Code, string FromDate, string ToDate)
        //{
        //    return CommonLibraryRepository.GetByParameters(Code, FromDate, ToDate);
        //}

        public ViewModelUserInformation GetUserInformation()
        {
            return repo.GetUserInformation();
        }

        public List<ApplicationLog> GetByParameters(string Code, string FromDate, string ToDate)
        {
            return repo.GetByParameters(Code, FromDate, ToDate);
        }

        public DbResult LogError(Exception lastError, string page, string errDetails, string referer = "")
        {
            return repo.LogError(lastError, page, errDetails, referer);
        }
    }
}
