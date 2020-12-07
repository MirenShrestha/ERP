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
    public class SettingsRepository
    {
        public DbResult Update(Settings obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@TaxPercentage", SqlDbType.Decimal) { Value = obj.TaxPercentage }
                                    ,new SqlParameter("@TaxType", SqlDbType.NVarChar, 30) { Value = obj.TaxType }
                                   

                                  };
            return SqlHelper.ParseDbResult("spSettings", param);
        }
        public Settings GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spSettings", param);
            Settings obj = new Settings();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.TaxPercentage = Convert.ToDecimal(result["TaxPercentage"]);
            obj.TaxType = result["TaxType"].ToString();
           
            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spSettings", param);
        }
        public List<Settings> List(bool Active = false)
        {
            List<Settings> lst = new List<Settings>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                   };

            DataTable result = SqlHelper.ExecuteDataTable("spSettings", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Settings obj = new Settings();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.TaxPercentage =Convert.ToDecimal(drow["TaxPercentage"]);
                    obj.TaxType = drow["TaxType"].ToString();
                   
                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
