using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.TicketingManagement
{
    public class CategoryRepository
    {
        public DbResult Update(Category obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 200) { Value = obj.Name}
                                    ,new SqlParameter("@Unit", SqlDbType.VarChar, 50) { Value = obj.Unit}
                                    ,new SqlParameter("@ShortName", SqlDbType.VarChar, 50) { Value = obj.ShortName}
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive}

                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                  };
            return SqlHelper.ParseDbResult("spCategory", param);
        }


        public Category GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spCategory", param);
            Category obj = new Category();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = Convert.ToString(result["Name"]);
            obj.Unit = result["Unit"].ToString();
            obj.ShortName = result["ShotName"].ToString();

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                         ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                        };
            return SqlHelper.ParseDbResult("spCategory", param);

        }

        public List<Category> List(bool Active = false)
        {
            List<Category> lst = new List<Category>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                     ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }};
            DataTable result = SqlHelper.ExecuteDataTable("spCategory", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Category obj = new Category();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.Unit = drow["Unit"].ToString();
                    obj.ShortName = drow["ShotName"].ToString();
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
