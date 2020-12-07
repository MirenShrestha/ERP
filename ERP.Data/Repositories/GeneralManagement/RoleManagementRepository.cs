using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.GeneralManagement
{
    public class RoleManagementRepository
    {
        public DbResult Update(AspNetUserRoles obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@RoleId", SqlDbType.NVarChar, 128) { Value = obj.RoleId }
                                    ,new SqlParameter("@UserId", SqlDbType.NVarChar, 128) { Value = obj.UserId }
                                  };
            return SqlHelper.ParseDbResult("spAspNetUserRoles", param);
        }
        public AspNetUserRoles GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@UserId", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spAspNetUserRoles", param);
            AspNetUserRoles obj = new AspNetUserRoles();
            obj.UserId = result["UserId"].ToString();
            obj.RoleId = result["RoleId"].ToString();

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spAspNetUserRoles", param);
        }
        public List<AspNetUserRolesVM> ListAll(bool Active = false)
        {
            List<AspNetUserRolesVM> lst = new List<AspNetUserRolesVM>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                   };

            DataTable result = SqlHelper.ExecuteDataTable("spAspNetUserRoles", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    AspNetUserRolesVM obj = new AspNetUserRolesVM();
                    obj.UserId = drow["UserId"].ToString();
                    obj.RoleId = drow["RoleId"].ToString();
                    obj.User = drow["UserName"].ToString();
                    obj.User = drow["UserName"].ToString();
                    obj.Role = drow["Role"].ToString();
                    lst.Add(obj);
                }
            }
            return lst;
        }
    }
}
