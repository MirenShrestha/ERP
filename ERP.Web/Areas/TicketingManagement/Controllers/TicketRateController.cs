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
    public class TicketRateController : BaseController
    {
        ITicketRateService iTicketRate;
        IDropDownService iDropDown;
        public TicketRateController(ITicketRateService ticketRateService, IDropDownService dropDownService)
        {
            iTicketRate = ticketRateService;
            iDropDown = dropDownService;
        }
        // GET: TicketingManagement/TicketRate
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<TicketRateVM> list = iTicketRate.List();
            return PartialView(list);
        }
        
        public ActionResult Create()
        {
            ViewBag.Type = new SelectList(iDropDown.GetDropDowns("types"), "Id", "DisplayName");  //iDropDown.GetDropDowns("types", "");
            ViewBag.Package = new SelectList(iDropDown.GetDropDowns("packages"), "Id", "DisplayName"); //iDropDown.GetDropDowns("packages", "");
            ViewBag.Category = new SelectList(iDropDown.GetDropDowns("categories"), "Id", "DisplayName"); //iDropDown.GetDropDowns("categories", "");


            return PartialView(new TicketRate());
        }

        [HttpPost]
        public ActionResult Create(TicketRate obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iTicketRate.Update(obj, "i");
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

        public ActionResult Edit(string id)
        {
            ViewBag.Type = new SelectList(iDropDown.GetDropDowns("types"), "Id", "DisplayName");  //iDropDown.GetDropDowns("types", "");
            ViewBag.Package = new SelectList(iDropDown.GetDropDowns("packages"), "Id", "DisplayName"); //iDropDown.GetDropDowns("packages", "");
            ViewBag.Category = new SelectList(iDropDown.GetDropDowns("categories"), "Id", "DisplayName"); //iDropDown.GetDropDowns("categories", "");

            TicketRate obj = iTicketRate.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(TicketRate obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iTicketRate.Update(obj, "u");
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


        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                var result = iTicketRate.Delete(id);
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
                return Json(new { ErrorCode = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


    }
}