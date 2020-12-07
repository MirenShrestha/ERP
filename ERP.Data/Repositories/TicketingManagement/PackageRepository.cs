using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.TicketingManagement
{
    public class PackageRepository
    {
        public DbResult Update(Package obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 200) { Value = obj.Name}
                                    ,new SqlParameter("@Code", SqlDbType.VarChar, 50) { Value = obj.Code}
                                  };
            return SqlHelper.ParseDbResult("spPackage", param);
        }

        public Package GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spPackage", param);
            Package obj = new Package();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = Convert.ToString(result["Name"]);
            obj.Code = result["Code"].ToString();
           
            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                        };
            return SqlHelper.ParseDbResult("spPackage", param);
        }

        public List<Package> List(bool Active = false)
        {
            List<Package> lst = new List<Package>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }};

            DataTable result = SqlHelper.ExecuteDataTable("spPackage", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Package obj = new Package();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.Code = drow["Code"].ToString();

                    lst.Add(obj);
                }
            }
            return lst;
        }



    }
}
