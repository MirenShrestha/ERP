using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Data.Repositories.GeneralManagement
{
    public class ShiftRepository
    {
        public DbResult Update(Shift obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 20) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 50) { Value = obj.Name }
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@StartTime", SqlDbType.VarChar,50) { Value = obj.StartTime }
                                    ,new SqlParameter("@EndTime", SqlDbType.VarChar,50) { Value = obj.EndTime }

                                  };
            return SqlHelper.ParseDbResult("spShift", param);
        }

        public Shift GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spShift", param);
            Shift obj = new Shift();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.IsActive = Convert.ToBoolean(result["IsActive"].ToString());
            obj.StartTime = Convert.ToString(result["StartTime"]);
            obj.EndTime = Convert.ToString(result["EndTime"].ToString());

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@Id", SqlDbType.Int) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spShift", param);
        }
        public List<Shift> List()
        {
            List<Shift> lst = new List<Shift>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a"}
                                   };
            DataTable result = SqlHelper.ExecuteDataTable("spShift", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Shift obj = new Shift();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);

                    obj.StartTime = Convert.ToString(drow["StartTime"]);
                    obj.EndTime = Convert.ToString(drow["EndTime"].ToString());

                    lst.Add(obj);
                }
            }
            return lst;
        }


    }
}
