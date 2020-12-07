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
    public class TicketRateRepository
    {
        public DbResult Update(TicketRate obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 100) { Value = obj.Name}
                                    ,new SqlParameter("@Code", SqlDbType.Int) { Value = obj.Code}
                                    ,new SqlParameter("@Category_id", SqlDbType.Int) { Value = obj.CategoryId}
                                    ,new SqlParameter("@Type_id", SqlDbType.Int) { Value = obj.TypeId}
                                    ,new SqlParameter("@Package_id", SqlDbType.Int) { Value = obj.PackageId}
                                    ,new SqlParameter("@Currency", SqlDbType.VarChar, 50) { Value = obj.Currency}
                                    ,new SqlParameter("@BaseRate", SqlDbType.Money) { Value = obj.BaseRate}
                                    ,new SqlParameter("@LocalTax", SqlDbType.Money) { Value = obj.LocalTax}
                                    ,new SqlParameter("@VAT", SqlDbType.Money) { Value = obj.VAT}
                                    ,new SqlParameter("@Total", SqlDbType.Money) { Value = obj.Total}
                                    ,new SqlParameter("@RoundOff", SqlDbType.Money) { Value = obj.RoundOff}
                                    ,new SqlParameter("@GrandTotal", SqlDbType.Money) { Value = obj.GrandTotal}
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@IsActive", SqlDbType.NVarChar,128) { Value =obj.IsActive }

                                  };
            return SqlHelper.ParseDbResult("spTicketRate", param);
        }
        public TicketRate GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spTicketRate", param);
            TicketRate obj = new TicketRate();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = Convert.ToString(result["Name"]);
            obj.Code = Convert.ToInt32(result["Code"]);
            obj.CategoryId = Convert.ToInt32(result["category_id"]);
            obj.TypeId = Convert.ToInt32(result["type_id"]);
            obj.PackageId = Convert.ToInt32(result["package_id"]);
            obj.Currency = Convert.ToString(result["Currency"]);

            obj.BaseRate = Convert.ToInt32(result["base_rate"]);
            obj.LocalTax = Convert.ToInt32(result["local_tax"]);
            obj.VAT = Convert.ToInt32(result["VAT"]);
            obj.Total = Convert.ToInt32(result["Total"]);
            obj.RoundOff = Convert.ToInt32(result["round_of"]);
            obj.GrandTotal = Convert.ToInt32(result["grand_total"]);
            obj.IsActive = Convert.ToBoolean(result["IsActive"]);

            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                        };
            return SqlHelper.ParseDbResult("spTicketRate", param);
        }

        public List<TicketRateVM> List(bool Active = false)
        {
            List<TicketRateVM> lst = new List<TicketRateVM>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" } };

            DataTable result = SqlHelper.ExecuteDataTable("spTicketRate", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    TicketRateVM obj = new TicketRateVM();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = Convert.ToString(drow["Name"]);
                    obj.Code = Convert.ToInt32(drow["Code"]);
                    obj.Category = Convert.ToString(drow["Category"]);
                    obj.Type = Convert.ToString(drow["Type"]);
                    obj.Package = Convert.ToString(drow["Package"]);
                    obj.Currency = Convert.ToString(drow["Currency"]);

                    obj.BaseRate = Convert.ToInt32(drow["base_rate"]);
                    obj.LocalTax = Convert.ToInt32(drow["local_tax"]);
                    obj.VAT = Convert.ToInt32(drow["VAT"]);
                    obj.Total = Convert.ToInt32(drow["Total"]);
                    obj.RoundOff = Convert.ToInt32(drow["round_of"]);
                    obj.GrandTotal = Convert.ToInt32(drow["grand_total"]);
                    obj.IsActive = Convert.ToBoolean(drow["IsActive"]);
                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
