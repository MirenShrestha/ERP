using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.GeneralManagement
{
    public class DeductionsRepository
    {
        public DbResult Update(Deductions obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 20) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 50) { Value = obj.Name }
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                  };
            return SqlHelper.ParseDbResult("spDeductions", param);
        }
        public Deductions GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spDeductions", param);
            Deductions obj = new Deductions();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.IsActive = Convert.ToBoolean(result["IsActive"].ToString());

            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@Id", SqlDbType.Int) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spDeductions", param);
        }
        public List<Deductions> List()
        {
            List<Deductions> lst = new List<Deductions>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a"}
                                   };
            DataTable result = SqlHelper.ExecuteDataTable("spDeductions", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Deductions obj = new Deductions();
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
