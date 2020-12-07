using ERP.Core.Models.TicketingManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Service.Interfaces.TicketingManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.TicketingManagement.Controllers
{
    public class CounterSettlementController : BaseController
    {
        ICounterSettlementService iSettlement;
        IDropDownService iDropDown;

        public CounterSettlementController(ICounterSettlementService settlementService, IDropDownService dropDownService)
        {
            iSettlement = settlementService;
            iDropDown = dropDownService;
        }
        // GET: TicketingManagement/CounterSettlement
        public ActionResult Index()
        {
            return PartialView();
        }
      
        public ActionResult Detail()
        {
            ViewBag.Type = new SelectList(iDropDown.GetDropDowns("counterUsers"), "Id", "DisplayName");  
            return PartialView(new Denomination());
        }

        public ActionResult GetReport(string userId, DateTime date)
        {
            try
            {
                ViewBag.Type = new SelectList(iDropDown.GetDropDowns("counterUsers"), "Id", "DisplayName");

                Denomination obj = iSettlement.CounterSettlement(userId,date);
                return PartialView("Detail", obj);
            }
            catch(Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }           
        }

        [HttpPost]
        public ActionResult Settled(Denomination obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iSettlement.Settle(obj);
                    return Json(new
                    {
                        ErrorCode = result.ErrorCode,
                        Message = result.Msg,
                        Id = result.Id,
                        JsonRequestBehavior.AllowGet
                    });
                }
                catch(Exception ex)
                {
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
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