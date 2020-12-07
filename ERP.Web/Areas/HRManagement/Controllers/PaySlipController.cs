using ERP.Core.Models.HRManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.HRManagement.Controllers
{
    public class PaySlipController : BaseController
    {
        IDropDownService iDropDown = null;

        public PaySlipController(IDropDownService iDropDownService)
        {
            iDropDown = iDropDownService;
        }
        // GET: HRManagement/PaySlip
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            return PartialView(new PaySlip());
        }

        public ActionResult Create()
        {
            ViewBag.EmployeeList = new SelectList(iDropDown.GetDropDowns("employee"), "Id", "DisplayName");

            return PartialView(new PaySlip());
        }

        #region slipDetails
        public ActionResult slipDetails()
        {
            ViewBag.Earnings = new SelectList(iDropDown.GetDropDowns("get-earnings"), "Id", "DisplayName");
            ViewBag.Deductions = new SelectList(iDropDown.GetDropDowns("get-deductions"), "Id", "DisplayName");

            PaySlipDetail obj = new PaySlipDetail();
            return PartialView(obj);
        }
        #endregion


    }
}