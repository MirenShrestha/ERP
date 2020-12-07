using ERP.Core.Models.HRManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Service.Interfaces.HRManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.HRManagement.Controllers
{
    public class LeaveApplicationController : BaseController
    {
        IDropDownService iDropDownService;
        ILeaveService ileave;

        public LeaveApplicationController(IDropDownService dropDownService, ILeaveService leaveService)
        {
            iDropDownService = dropDownService;
            ileave = leaveService;
        }
        // GET: HRManagement/LeaveApplication
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            List<LeaveApplicationVM> lst = ileave.AllList();
            return PartialView(lst);
        }

        public ActionResult Create()
        {
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            return PartialView(new LeaveApplication());
        }

        [HttpPost]
        public ActionResult Create(LeaveApplication obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = ileave.Update(obj, "i");
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
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            ViewBag.Employee = new SelectList(iDropDownService.GetDropDowns("employee"), "Id", "DisplayName");

            LeaveApplication obj = ileave.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(LeaveApplication obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = ileave.Update(obj, "u");
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
                var result = ileave.Delete(id);
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

        [HttpPost]
        public ActionResult Action(string id, string type)
        {
            try
            {
                var result = ileave.LeaveAction(id,type);
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

        public JsonResult GetEmployee(string id)
        {
            var Emp = iDropDownService.GetDropDowns("employee", id).Select(r => new { value = r.Id, text = r.DisplayName });
            return Json(Emp, JsonRequestBehavior.AllowGet);
        }



    }
}