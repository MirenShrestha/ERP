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
    public class AgentsRepository
    {
        public DbResult Update(Agents obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.NVarChar, 50) { Value = obj.Name }
                                    ,new SqlParameter("@Address", SqlDbType.NVarChar, 50) { Value = obj.Address }
                                    ,new SqlParameter("@Telephone", SqlDbType.VarChar, 20) { Value = obj.Telephone }
                                    ,new SqlParameter("@CommissionPercentage", SqlDbType.Decimal) { Value = obj.CommissionPercentage }
                                    ,new SqlParameter("@IsActive", SqlDbType.Bit) { Value = obj.IsActive }
                                    ,new SqlParameter("@VAT", SqlDbType.VarChar,200) { Value = obj.VATPAN }

                                  };
            return SqlHelper.ParseDbResult("spAgents", param);
        }
        public Agents GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spAgents", param);
            Agents obj = new Agents();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.Address = result["Address"].ToString();
            obj.Telephone = result["Telephone"].ToString();
            obj.CommissionPercentage = Convert.ToDecimal(result["CommissionPercentage"]);
            obj.IsActive = Convert.ToBoolean(result["IsActive"]);
            obj.VATPAN = result["vat_no"].ToString();
            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@Id", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spAgents", param);
        }

        public List<Agents> List(bool Active = false)
        {
            List<Agents> lst = new List<Agents>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                   };

            DataTable result = SqlHelper.ExecuteDataTable("spAgents", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Agents obj = new Agents();
                    obj.Id = Convert.ToInt32(drow["Id"].ToString());
                    obj.Name = drow["Name"].ToString();
                    obj.Address = drow["Address"].ToString();
                    obj.Telephone = drow["Telephone"].ToString();
                    obj.CommissionPercentage = Convert.ToDecimal(drow["CommissionPercentage"]);
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);
                    obj.VATPAN = drow["vat_no"].ToString();

                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
