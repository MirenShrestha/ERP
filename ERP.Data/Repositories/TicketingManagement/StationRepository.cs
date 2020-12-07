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
    public class StationRepository
    {
        public DbResult Update(Station obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 100) { Value = obj.Name}
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                  };
            return SqlHelper.ParseDbResult("spStation", param);
        }

        public Station GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spStation", param);
            Station obj = new Station();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = Convert.ToString(result["Name"]);
            obj.IsActive = Convert.ToBoolean(result["IsActive"]);
            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                         ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                        };
            return SqlHelper.ParseDbResult("spStation", param);
        }

        public List<Station> List(bool Active = false)
        {
            List<Station> lst = new List<Station>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                     ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }};
            DataTable result = SqlHelper.ExecuteDataTable("spStation", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Station obj = new Station();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();                   
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }


    }
}
