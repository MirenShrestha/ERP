using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Data.Repositories.TicketingManagement
{
    public class CounterSettlementRepository
    {
        public Denomination CounterSettlement(string userId, DateTime date)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Date", SqlDbType.Date) { Value = date}
                                    ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =userId}
                                   };
            var result = SqlHelper.ExecuteDataSet("spCounterSettlement", param);
            Denomination obj = new Denomination();
            if (result.Tables.Count == 2)
            {
                DataTable tbl = result.Tables[0];

                if (result.Tables[1].Rows.Count > 0)
                {
                    DataRow tbl1 = result.Tables[1].Rows[0];

                    obj.Id = Convert.ToInt32(tbl1["Id"]);
                    obj.Rs1000 = Convert.ToDecimal(tbl1["Rs1000"]);
                    obj.Rs500 = Convert.ToDecimal(tbl1["Rs500"]);
                    obj.Rs100 = Convert.ToDecimal(tbl1["Rs100"]);
                    obj.Rs50 = Convert.ToDecimal(tbl1["Rs50"]);
                    obj.Rs20 = Convert.ToDecimal(tbl1["Rs20"]);
                    obj.Rs10 = Convert.ToDecimal(tbl1["Rs10"]);
                    obj.Rs5 = Convert.ToDecimal(tbl1["Rs5"]);
                    obj.Coins = Convert.ToDecimal(tbl1["Coins"]);
                    obj.IC = Convert.ToDecimal(tbl1["IC"]);
                    obj.SettlementRequest = Convert.ToString(tbl1["SettlementRequest"]);
                    obj.Impression = Convert.ToString(tbl1["Impression"]);
                    //obj.SettledBy = Convert.ToString(tbl["SettledBy"]);
                    obj.Remarks = Convert.ToString(tbl1["Remarks"]);
                    obj.Status = Convert.ToInt32(tbl1["Status"]);

                    List<DenominationGraph> list = new List<DenominationGraph>();
                    foreach (DataRow dr in tbl.Rows)
                    {
                        DenominationGraph obj1 = new DenominationGraph();

                        obj1.PaymentMode = dr["PaymentMode"].ToString();
                        obj1.GrandTotal = Convert.ToDecimal(dr["GrandTotal"]);

                        list.Add(obj1);
                    }
                    obj.GraphList = list;
                }

            }
            return obj;

        }

        public DbResult Settle(Denomination obj)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="approve"}
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@Remarks", SqlDbType.VarChar,100) { Value = obj.Remarks }
                                    ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID()}
                                  };
            return SqlHelper.ParseDbResult("spCounterSettlement", param);
        }
    }
}
