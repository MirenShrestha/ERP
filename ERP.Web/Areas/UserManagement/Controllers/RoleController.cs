using ERP.Core.Models.UserManagement;
using ERP.Service.Interfaces.UserManagement;
using ERP.Web.Controllers;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.UserManagement.Controllers
{
    public class RoleController : BaseController
    {
        IRoleService iAppService = null;

        public RoleController(IRoleService roleService)
        {
            iAppService = roleService;
        }


        // GET: UserManagement/Role
        public ActionResult Index()
        {
            return PartialView();
        }


        public ActionResult List()
        {
            IEnumerable<Role> list = iAppService.List();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            return PartialView(new Role());
        }

        [HttpPost]
        public ActionResult Create(Role obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    //RoleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(new MyDbContext()));
                    //var str = RoleManager.Create(new IdentityRole(roleName));

                    //var result = iAppService.Update(obj, "i");
                    //return Json(new
                    //{
                    //    ErrorCode = result.ErrorCode,
                    //    Message = result.Msg,
                    //    Id = result.Id,
                    //    JsonRequestBehavior.AllowGet
                    //});
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
            Role obj = iAppService.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(Role obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iAppService.Update(obj, "u");
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
                var result = iAppService.Delete(id);
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