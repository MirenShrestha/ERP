using ERP.Common.Helper;
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
    public class FiscalYearRepository
    {
        public DbResult Update(FiscalYear obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@ShortName", SqlDbType.NVarChar, 50) { Value = obj.ShortName }
                                    ,new SqlParameter("@YearCode", SqlDbType.NVarChar, 50) { Value = obj.YearCode }
                                    ,new SqlParameter("@StartDate", SqlDbType.DateTime) { Value = obj.StartDate }
                                    ,new SqlParameter("@EndDate", SqlDbType.DateTime) { Value = obj.EndDate }

                                  };
            return SqlHelper.ParseDbResult("spFiscalYear", param);
        }
        public FiscalYear GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spFiscalYear", param);
            FiscalYear obj = new FiscalYear();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.ShortName = result["ShortName"].ToString();
            obj.YearCode = result["YearCode"].ToString();
            obj.StartDate = Convert.ToDateTime((result["StartDate"]));
            obj.EndDate = Convert.ToDateTime(result["EndDate"]);

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spFiscalYear", param);
        }
        public List<FiscalYear> List(bool Active = false)
        {
            List<FiscalYear> lst = new List<FiscalYear>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                  };

            DataTable result = SqlHelper.ExecuteDataTable("spFiscalYear", param);


            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    FiscalYear obj = new FiscalYear();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.ShortName = drow["ShortName"].ToString();
                    obj.YearCode = drow["YearCode"].ToString();
                    obj.StartDate = Convert.ToDateTime(drow["StartDate"]);
                    obj.EndDate = Convert.ToDateTime(drow["EndDate"].ToString());
                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
