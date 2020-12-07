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
    public class SettingsController : BaseController
    {
        ISettingsService iSettings;

        public SettingsController(ISettingsService _settings)
        {
            iSettings = _settings;
        }

        // GET: GeneralManagement/Settings
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<Settings> list = iSettings.List();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            return PartialView(new Settings());
        }

        [HttpPost]
        public ActionResult Create(Settings obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iSettings.Update(obj, "i");
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
            Settings obj = iSettings.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(Settings obj)
        {
            if (ModelState.IsValid)
            {
                {
                    try
                    {
                        var result = iSettings.Update(obj, "u");
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
                var result = iSettings.Delete(id);
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