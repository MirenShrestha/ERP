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
    public class OrganisationController : BaseController
    {
        IOrganistaionService iOrganistaion = null;

        public OrganisationController(IOrganistaionService _organistaionService)
        {
            iOrganistaion = _organistaionService;
        }
        // GET: GeneralManagement/Organisation
        public ActionResult Index()
        {
            return PartialView();
        }
        public ActionResult List()
        {
            IEnumerable<Organisation> list = iOrganistaion.List();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            IEnumerable<Organisation> list = iOrganistaion.List();
            int cnt = list.Count();
            if (cnt > 0)
            {
                string id = list.Select(a => a.Id).FirstOrDefault().ToString();
                Organisation obj = iOrganistaion.GetById(id);
                return PartialView(obj);
            }
            else
            {
                return PartialView(new Organisation());
            }
        }

        [HttpPost]
        public ActionResult Create(Organisation obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string flag = "u";
                    if (obj.Id < 1)
                    {
                        flag = "i";
                    }
                    var result = iOrganistaion.Update(obj, flag);
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
            Organisation obj = iOrganistaion.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(Organisation obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iOrganistaion.Update(obj, "u");
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

        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                var result = iOrganistaion.Delete(id);
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

    }
}