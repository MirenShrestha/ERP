using ERP.Data.Repositories.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.TicketingManagement
{
    public class ReportService : IReportService
    {
        ReportRepository repo;
        public ReportService()
        {
            repo = new ReportRepository();
        }

        public DataTable ComplementarySummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            return repo.ComplementarySummaryReport(fDate, tDate, operatorId);
        }

        public DataTable ComplementarySummary_Report(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            return repo.ComplementarySummary_Report(fDate, tDate, operatorId);
        }

        public DataTable DiscountSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            return repo.DiscountSummaryReport(fDate, tDate, operatorId);
        }

        public DataTable GetAgentReport(DateTime fDate, DateTime tDate, int agentId)
        {
            return repo.GetAgentReport(fDate,tDate,agentId);
        }

        public DataTable GetCounterSettlementReport(DateTime fDate, DateTime tDate, string operatorId)
        {
            return repo.GetCounterSettlementReport(fDate,tDate,operatorId);
        }

        public DataTable ItemBasedReport(DateTime fDate, DateTime tDate, int? itemId)
        {
            return repo.ItemBasedReport(fDate, tDate, itemId);
        }

        public DataTable PackageCategoryReport(DateTime fDate, DateTime tDate, int? packageId, int? CategoryId, string flag)
        {
            return repo.PackageCategoryReport(fDate, tDate, packageId, CategoryId, flag);
        }

        public DataTable SalesReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            return repo.SalesReport(fDate, tDate, operatorId);
        }

        public DataTable SalesSummaryReport(DateTime? fDate, DateTime? tDate, string operatorId)
        {
            return repo.SalesSummaryReport(fDate, tDate, operatorId);
        }
    }
}
