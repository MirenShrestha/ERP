using ERP.Service.Interfaces.GeneralManagement;
using ERP.Service.Interfaces.TicketingManagement;
using ERP.Web.Controllers;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.TicketingManagement.Controllers
{
    public class ReportController : BaseController
    {
        IDropDownService iDropDown = null;
        IReportService iReport = null;
        public ReportController(IDropDownService dropDownService, IReportService reportService)
        {
            iDropDown = dropDownService;
            iReport = reportService;
        }
        // GET: TicketingManagement/Report
        public ActionResult Index()
        {
            ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
            ViewBag.ReportViewer = null;
            return PartialView();
        }

        public ActionResult ReportView(DateTime? fdate, DateTime? tdate, string operatorId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
                //var population = iReport.SalesReport(fdate,tdate,operatorId);
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/SalesReport.aspx?from={0}&to={1}&operator={2}", fdate, tdate, operatorId);
                return Json(url, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult SalesSummary()
        {
            ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
            return PartialView();
        }

        public ActionResult SalesSummaryView(DateTime? fdate, DateTime? tdate, string operatorId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/SalesSummary.aspx?from={0}&to={1}&operator={2}", fdate, tdate, operatorId);
                return Json(url, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult DiscountReport()
        {
            ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
            return PartialView();
        }

        public ActionResult DiscountReportView(DateTime? fdate, DateTime? tdate, string operatorId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/DiscountReport.aspx?from={0}&to={1}&operator={2}", fdate, tdate, operatorId);
                return Json(url, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ComplementaryReport()
        {
            ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
            return PartialView();
        }

        public ActionResult ComplementaryReportView(DateTime? fdate, DateTime? tdate, string operatorId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/ComplementaryReport.aspx?from={0}&to={1}&operator={2}", fdate, tdate, operatorId);
                return Json(url, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult PackageReport()
        {
            ViewBag.Packages = new SelectList(iDropDown.GetDropDowns("packages"), "Id", "DisplayName");

            return PartialView();
        }

        [HttpPost]
        public ActionResult PackageReport(DateTime fdate, DateTime tdate, string packageId, string categoryId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.Packages = new SelectList(iDropDown.GetDropDowns("packages"), "Id", "DisplayName");

                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/PackageReport.aspx?from={0}&to={1}&packageId={2}&categoryId={3}", fdate, tdate, packageId, categoryId);
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult CategoryReport()
        {
            ViewBag.Categories = new SelectList(iDropDown.GetDropDowns("categories"), "Id", "DisplayName");

            return PartialView();
        }
        [HttpPost]
        public ActionResult CategoryReport(DateTime fdate, DateTime tdate, string categoryId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.Categories = new SelectList(iDropDown.GetDropDowns("categories"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/CategoryReport.aspx?from={0}&to={1}&categoryId={2}", fdate, tdate, categoryId);
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult ItemBasedReport()
        {
            ViewBag.ticketItems = new SelectList(iDropDown.GetDropDowns("ticketItems"), "Id", "DisplayName");
            return PartialView();
        }
        [HttpPost]
        public ActionResult ItemBasedReportView(DateTime fdate, DateTime tdate, string itemId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.ticketItems = new SelectList(iDropDown.GetDropDowns("ticketItems"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/ItemBasedReport.aspx?from={0}&to={1}&itemId={2}", fdate, tdate, itemId);
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult AgentReport()
        {

            ViewBag.agents = new SelectList(iDropDown.GetDropDowns("agents"), "Id", "DisplayName");
            return PartialView();
        }

        [HttpPost]
        public ActionResult AgentReportView(DateTime fdate, DateTime tdate, string agentId)
        {

            string url = "";
            string initURL = "";
            try
            {
                ViewBag.agents = new SelectList(iDropDown.GetDropDowns("agents"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/AgentReport.aspx?from={0}&to={1}&itemId={2}", fdate, tdate, agentId);
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult CounterSettlementReport()
        {
            ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
            return PartialView();
        }

        [HttpPost]
        public ActionResult CounterSettlementReportView(DateTime fdate, DateTime tdate, string userId)
        {
            string url = "";
            string initURL = "";
            try
            {
                ViewBag.TicketOperator = new SelectList(iDropDown.GetDropDowns("ticketUsers"), "Id", "DisplayName");
                initURL = System.Configuration.ConfigurationManager.AppSettings["TicketReportPath"].ToString();
                url = string.Format(initURL + "ReportVIewer/TicketingManagement/CounterSettlementReport.aspx?from={0}&to={1}&userId={2}", fdate, tdate, userId);
                return Json(url, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}