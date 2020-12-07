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
    public class ShiftController : BaseController
    {
        IShiftService iShift;
        public ShiftController(IShiftService shiftService)
        {
            iShift = shiftService;
        }
        // GET: GeneralManagement/Shift
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            var list = iShift.List();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            return PartialView(new Shift());
        }

        [HttpPost]
        public ActionResult Create(Shift obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iShift.Update(obj, "i");
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
            try
            {
                Shift obj = iShift.GetById(id);
                return PartialView(obj);
            }
            catch(Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public ActionResult Edit(Shift obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iShift.Update(obj, "u");
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
                var result = iShift.Delete(id);
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
    }
}