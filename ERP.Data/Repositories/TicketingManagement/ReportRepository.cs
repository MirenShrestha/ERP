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
    public class ReportRepository
    {

        public DataTable SalesReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@operatorId", SqlDbType.NVarChar,128) { Value = operatorId }
                                    ,new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }

            };
            DataTable result = SqlHelper.ExecuteDataTable("SP_GET_VAT_LEDGER", param);


            return result;
        }
        public DataTable SalesSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@operatorId", SqlDbType.NVarChar,128) { Value = operatorId }
                                    ,new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }

            };
            DataTable result = SqlHelper.ExecuteDataTable("SP_GET_SUMMARY", param);


            return result;
        }
        public DataTable ComplementarySummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@operatorId", SqlDbType.NVarChar,128) { Value = operatorId }
                                    ,new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }

            };
            DataTable result = SqlHelper.ExecuteDataTable("SP_GET_COMPLEMENTARY", param);


            return result;
        }
        public DataTable DiscountSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@operatorId", SqlDbType.NVarChar,128) { Value = operatorId }
                                    ,new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }

            };
            DataTable result = SqlHelper.ExecuteDataTable("SP_GET_DISCOUNT_SUMMARY", param);

            return result;
        }

        public DataTable ComplementarySummary_Report(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@operatorId", SqlDbType.NVarChar,128) { Value = operatorId }
                                    ,new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }

            };
            DataTable result = SqlHelper.ExecuteDataTable("spComplementaryReport", param);

            return result;
        }

        public DataTable PackageCategoryReport(DateTime fDate, DateTime tDate, int? packageId, int? CategoryId, string flag)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }
                                    ,new SqlParameter("@flag", SqlDbType.VarChar,30) { Value = flag }
                                    ,new SqlParameter("@packageId", SqlDbType.Int) { Value = packageId }
                                    ,new SqlParameter("@categoryId", SqlDbType.Int) { Value = CategoryId }

            };

            DataTable result = SqlHelper.ExecuteDataTable("spGetPackage_CategoryReport", param);

            return result;
        }

        public DataTable ItemBasedReport(DateTime fDate, DateTime tDate, int? itemId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }
                                    ,new SqlParameter("@itemId", SqlDbType.Int) { Value = itemId }

            };

            DataTable result = SqlHelper.ExecuteDataTable("spGetItemBasedReport", param);

            return result;
        }
        public DataTable GetAgentReport(DateTime fDate, DateTime tDate, int agentId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }
                                    ,new SqlParameter("@agentId", SqlDbType.Int) { Value = agentId }

            };

            DataTable result = SqlHelper.ExecuteDataTable("spGetAgentReport", param);

            return result;
        }

        public DataTable GetCounterSettlementReport(DateTime fDate, DateTime tDate, string operatorId)
        {
            SqlParameter[] param = {
                                     new SqlParameter("@from", SqlDbType.Date) { Value =fDate }
                                    ,new SqlParameter("@to", SqlDbType.Date) { Value = tDate }
                                    ,new SqlParameter("@userId", SqlDbType.VarChar,128) { Value = operatorId }

            };

            DataTable result = SqlHelper.ExecuteDataTable("spGetDenominationReport", param);

            return result;
        }
    }
}
