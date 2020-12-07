using ERP.Common.Helper;
using ERP.Common.Helper.DateConversion;
using ERP.Core.Models.GeneralManagement;
using ERP.Service.Services.GeneralManagement;
using ERP.Service.Services.TicketingManagement;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace ERP.Web.ReportVIewer.TicketingManagement
{
    public partial class DiscountReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = "D:\\Projects\\Sofwena\\Sofwena-ERP\\ERP1\\ERP.Web\\RDLC\\TicketingManagement\\DiscountReport.rdlc";

                ReportService service = new ReportService();
                OrganisationService companyInfo = new OrganisationService();

                string from = Request.QueryString.Get("from");
                string to = Request.QueryString.Get("to");
                string operatorId = Request.QueryString.Get("operator");

                DateTime? tDate = null;
                DateTime? fDate = null;
                NPDate date = new NPDate();

                string f_DateBS = "";
                string t_DateBS = "";


                if (!string.IsNullOrEmpty(from))
                {
                    fDate = Convert.ToDateTime(from);
                }

                if (!string.IsNullOrEmpty(to))
                {
                    tDate = Convert.ToDateTime(to);
                }
                DataTable dt = service.DiscountSummaryReport(fDate, tDate, operatorId);

                object maxDate = dt.Compute("MAX(CreatedDate)", null);
                object minDate = dt.Compute("MIN(CreatedDate)", null);

                if (string.IsNullOrEmpty(from))
                {
                    f_DateBS = minDate.ToString();
                    fDate = Convert.ToDateTime(f_DateBS);
                    f_DateBS = date.GetNepaliDate(Convert.ToDateTime(f_DateBS)).npDate;
                }
                else
                {
                    f_DateBS = date.GetNepaliDate(Convert.ToDateTime(fDate)).npDate;
                }

                if (string.IsNullOrEmpty(to))
                {
                    t_DateBS = maxDate.ToString();
                    tDate = Convert.ToDateTime(t_DateBS);
                    t_DateBS = date.GetNepaliDate(Convert.ToDateTime(t_DateBS)).npDate;
                }
                else
                {
                    t_DateBS = date.GetNepaliDate(Convert.ToDateTime(tDate)).npDate;
                }

                List<Organisation> company = companyInfo.List().ToList();
                if (company.Count > 0)
                {
                    ReportParameter companyName = new ReportParameter("companyName", company[0].Name);
                    ReportViewer1.LocalReport.SetParameters(companyName);

                    ReportParameter address = new ReportParameter("address", company[0].Address);
                    ReportViewer1.LocalReport.SetParameters(address);
                }

                string fromAD = GlobalHelper.ToShortDate(fDate.ToString());
                string toAD = GlobalHelper.ToShortDate(tDate.ToString());

                ReportParameter fDateAD = new ReportParameter("fDateAD", fromAD);
                ReportViewer1.LocalReport.SetParameters(fDateAD);

                ReportParameter tDateAD = new ReportParameter("tDateAD", toAD);
                ReportViewer1.LocalReport.SetParameters(tDateAD);

                ReportParameter fDateBS = new ReportParameter("fDateBS", f_DateBS.ToString());
                ReportViewer1.LocalReport.SetParameters(fDateBS);

                ReportParameter tDateBS = new ReportParameter("tDateBS", t_DateBS.ToString());
                ReportViewer1.LocalReport.SetParameters(tDateBS);

                string userName = Session["userName"].ToString();
                string fyCode = Session["fiscalCode"].ToString();

                ReportParameter User = new ReportParameter("User", userName);
                ReportViewer1.LocalReport.SetParameters(User);

                ReportParameter fy = new ReportParameter("fy", fyCode);
                ReportViewer1.LocalReport.SetParameters(fy);



                ReportViewer1.LocalReport.DataSources.Clear();
                ReportDataSource datasource = new ReportDataSource("DiscountSummary", dt);
                ReportViewer1.LocalReport.DataSources.Add(datasource);
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
}