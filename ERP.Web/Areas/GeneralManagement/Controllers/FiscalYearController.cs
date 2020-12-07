using ERP.Core.Models.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.GeneralManagement.Controllers
{
    public class FiscalYearController : BaseController
    {
        IFiscalYearService iFiscalYear = null;

        public FiscalYearController(IFiscalYearService iFiscal)
        {
            iFiscalYear = iFiscal;
        }
        // GET: GeneralManagement/FiscalYear
        public ActionResult Index()
        {
            return PartialView();
        }
        public ActionResult List()
        {
            IEnumerable<FiscalYear> list = iFiscalYear.List();
            return PartialView(list);
        }

        public ActionResult Update()
        {
            IEnumerable<FiscalYear> list = iFiscalYear.List();
            int cnt = list.Count();
            if (cnt > 0)
            {
                string id = list.Select(a => a.Id).FirstOrDefault().ToString();
                FiscalYear obj = iFiscalYear.GetById(id);
                return PartialView(obj);
            }
            else
            {
                FiscalYear obj = new FiscalYear();
                obj.StartDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                obj.EndDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());

                return PartialView(obj);
            }
        }

        [HttpPost]
        public ActionResult Update(FiscalYear obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string flag = "u";
                    if ( obj.Id < 1)
                    {
                        flag = "i";
                    }
                    var result = iFiscalYear.Update(obj, flag);
                    return Json(new
                    {
                        ErrorCode = result.ErrorCode,
                        Message = result.Msg,
                        Id = result.Id,
                        JsonRequestBehavior.AllowGet
                    });
                }
                catch (Exception ex)
                {
                    return Json(new { ErrorCode = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }
    }
}