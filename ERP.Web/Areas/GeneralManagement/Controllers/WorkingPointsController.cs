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
    public class WorkingPointsController : BaseController
    {

        IWorkinPointService iWorking;
        public WorkingPointsController(IWorkinPointService workinPointService)
        {
            iWorking = workinPointService;
        }
        // GET: GeneralManagement/WorkinPoints
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<WorkingPoints> obj = iWorking.List();
            return PartialView(obj);
        }

        public ActionResult Create()
        {
            return PartialView(new WorkingPoints());
        }

        [HttpPost]
        public ActionResult Create(WorkingPoints obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iWorking.Update(obj, "i");
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
            WorkingPoints obj = iWorking.GetById(id);
            return PartialView(obj);
        }


        [HttpPost]
        public ActionResult Edit(WorkingPoints obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iWorking.Update(obj, "u");
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
                var result = iWorking.Delete(id);
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