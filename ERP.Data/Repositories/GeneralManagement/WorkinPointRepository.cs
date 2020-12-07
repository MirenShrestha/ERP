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
    public class WorkinPointRepository
    {
        public DbResult Update(WorkingPoints obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 20) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 50) { Value = obj.Name }
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Code", SqlDbType.Int) { Value = obj.Code }

                                  };
            return SqlHelper.ParseDbResult("spWorkingPoints", param);
        }
        public WorkingPoints GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spWorkingPoints", param);
            WorkingPoints obj = new WorkingPoints();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.Code = result["Code"].ToString();
            obj.IsActive = Convert.ToBoolean(result["IsActive"].ToString());

            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@Id", SqlDbType.Int) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spWorkingPoints", param);
        }
        public List<WorkingPoints> List()
        {
            List<WorkingPoints> lst = new List<WorkingPoints>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a"}
                                   };
            DataTable result = SqlHelper.ExecuteDataTable("spWorkingPoints", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    WorkingPoints obj = new WorkingPoints();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.Code = drow["Code"].ToString();
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
