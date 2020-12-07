using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.Common;
using ERP.Core.Models.UserManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Mvc;

namespace ERP.Data.Repositories
{
    public  class CommonLibraryRepository
    {
        public  DbResult LogError(Exception lastError, string page,string errDetails, string referer = "")
        {
            Exception err = lastError;
            if (lastError.InnerException != null)
                err = lastError.InnerException;

            var errPage = GlobalHelper.FilterString(page);
            var errMsg = GlobalHelper.FilterString(err.Message);
            var user = SessionHelper.GetUserID();
            var ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];   
            if (string.IsNullOrWhiteSpace(user))
            {
                user = ipAddress;
            }

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="i" }
                                    ,new SqlParameter("@errorPage", SqlDbType.VarChar) { Value =errPage}
                                    ,new SqlParameter("@errorMsg", SqlDbType.VarChar) { Value = errMsg}
                                    ,new SqlParameter("@errorDetails", SqlDbType.VarChar) { Value =errDetails}
                                    ,new SqlParameter("@referer", SqlDbType.VarChar) { Value =referer }
                                    ,new SqlParameter("@ipAddress", SqlDbType.VarChar, 100) { Value =ipAddress }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =user}
                                  };
            return SqlHelper.ParseDbResult("spApplicationLog", param);
        }
       
        public  ViewModelUserInformation GetUserInformation()
        {
            SqlParameter[] param = {
                                    new SqlParameter("@flag", SqlDbType.VarChar,100) {Value = "user-info"}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    };

           
            DataRow result = SqlHelper.ExecuteDataRow("spUserProfile", param);
            ViewModelUserInformation userInfo = new ViewModelUserInformation();
            if(result.Table.Rows.Count>0)
            {
                userInfo.FullName = Convert.ToString(result["FullName"]);
                userInfo.CompanyId = Convert.ToString(result["CompanyId"]);
                userInfo.CompanyName = Convert.ToString(result["CompanyName"]);
                userInfo.CompanyCode = Convert.ToString(result["CompanyCode"]);
                userInfo.Email = Convert.ToString(result["Email"]);
                userInfo.Phone = Convert.ToString(result["Phone"]);
                userInfo.SessionTimeOut = result["SessionTimeOut"] != DBNull.Value ? Convert.ToInt32(result["SessionTimeOut"]) : (int?)null;  
                userInfo.DOB = result["DOB"] != DBNull.Value ? Convert.ToDateTime(result["DOB"]) : (DateTime?)null;
                userInfo.Gender = Convert.ToString(result["Gender"]);
                userInfo.FiscalCode = Convert.ToString(result["Fiscal"]);

            }
            return userInfo;
        }

        public  List<ApplicationLog> GetByParameters(string Code, string FromDate, string ToDate)
            {
                SqlParameter[] param = { new SqlParameter("@id", SqlDbType.VarChar, 50) { Value = Code },
                                     new SqlParameter("@fromDate", SqlDbType.VarChar, 50) { Value = FromDate},
                                     new SqlParameter("@toDate", SqlDbType.VarChar,50){ Value = ToDate},
                                     new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a" }

                                   };
                DataTable result = SqlHelper.ExecuteDataTable("spApplicationLog", param);

                List<ApplicationLog> lst = new List<ApplicationLog>();
                if (result != null && result.Rows.Count > 0)
                {
                    foreach (DataRow drow in result.Rows)
                    {
                        ApplicationLog obj = new ApplicationLog();
                        obj.Id = Convert.ToInt32(drow["Id"]);
                        obj.ErrorDetails = Convert.ToString(drow["ErrorDetails"]);
                        obj.ErrorMsg = Convert.ToString(drow["ErrorMsg"]);
                        obj.ErrorPage = Convert.ToString(drow["ErrorPage"]);
                        obj.IpAddress = Convert.ToString(drow["IpAddress"]);
                        obj.Referer = Convert.ToString(drow["Referer"]);
                        obj.CreatedBy = Convert.ToString(drow["CreatedBy"]);
                        obj.CreatedDate = Convert.ToDateTime(drow["CreatedDate"]);
                        lst.Add(obj);
                    }
                }
                return lst;
            }


    }
}
