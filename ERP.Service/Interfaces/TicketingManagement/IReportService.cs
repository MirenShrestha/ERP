using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Interfaces.TicketingManagement
{
    public interface IReportService
    {
        DataTable SalesReport(DateTime? fDate, DateTime? tDate, string operatorId);
        DataTable SalesSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId);
        DataTable ComplementarySummaryReport(DateTime? fDate, DateTime? tDate, string operatorId);
        DataTable DiscountSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId);
        DataTable ComplementarySummary_Report(DateTime? fDate, DateTime? tDate, string operatorId);
        DataTable PackageCategoryReport(DateTime fDate, DateTime tDate, int? packageId, int? CategoryId, string flag);
        DataTable ItemBasedReport(DateTime fDate, DateTime tDate, int? itemId);
        DataTable GetAgentReport(DateTime fDate, DateTime tDate, int agentId);
        DataTable GetCounterSettlementReport(DateTime fDate, DateTime tDate, string operatorId);
    }
}
