using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.UserManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.UserManagement
{
    public class RoleRepository
    {
        public DbResult Update(Role obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.NVarChar, 128) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 100) { Value = obj.Name}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                  };
            return SqlHelper.ParseDbResult("spRole", param);
        }


        public Role GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spRole", param);
            Role obj = new Role();
            obj.Id = Convert.ToString(result["Id"]);
            obj.Name = Convert.ToString(result["Name"]);
            obj.CreatedBy = Convert.ToString(result["CreatedBy"]);
            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                         ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                        };
            return SqlHelper.ParseDbResult("spRole", param);

        }

        public List<Role> List(bool Active = false)
        {
            List<Role> lst = new List<Role>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                     ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }};
            DataTable result = SqlHelper.ExecuteDataTable("spRole", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Role obj = new Role();
                    obj.Id = drow["Id"].ToString();
                    obj.Name = drow["Name"].ToString();
                    obj.CreatedBy = drow["CreatedBy"].ToString();
                    lst.Add(obj);
                }
            }
            return lst;
        }
    }
}
