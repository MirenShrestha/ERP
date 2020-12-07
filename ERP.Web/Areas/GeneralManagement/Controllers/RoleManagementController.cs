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
    public class RoleManagementController : BaseController
    {
        IRoleManagementService iRoleManage;
        IDropDownService iDropDownService = null;

        public RoleManagementController(IRoleManagementService roleManagementService, IDropDownService iDropDownServ)
        {
            iRoleManage = roleManagementService;
            iDropDownService = iDropDownServ;
        }
        // GET: GeneralManagement/RoleManagement
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<AspNetUserRolesVM> list = iRoleManage.ListAll();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            ViewBag.Roles = new SelectList(iDropDownService.GetDropDowns("roles"), "Id", "DisplayName");
            ViewBag.Users = new SelectList(iDropDownService.GetDropDowns("users"), "Id", "DisplayName");

            return PartialView(new AspNetUserRoles());
        }

        [HttpPost]
        public ActionResult Create(AspNetUserRoles obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iRoleManage.Update(obj, "i");
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
            ViewBag.Roles = new SelectList(iDropDownService.GetDropDowns("roles"), "Id", "DisplayName");
            ViewBag.Users = new SelectList(iDropDownService.GetDropDowns("users"), "Id", "DisplayName");

            AspNetUserRoles obj = iRoleManage.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(AspNetUserRoles obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iRoleManage.Update(obj, "u");
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
                var result = iRoleManage.Delete(id);
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
