using ERP.Core.Models.GeneralManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Web.Controllers;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.GeneralManagement.Controllers
{
    public class DepartmentController : BaseController
    {
        IDepartmentService iDepartment;
        public DepartmentController(IDepartmentService departmentService)
        {
            iDepartment = departmentService;
        }

        // GET: GeneralManagement/Department
        //[Authorize(Roles = "Admin")]
        public ActionResult Index()
        {
           
            //var b = User.Identity.Name;
            //bool bq = User.IsInRole("Super Admin");
            return View();
        }

        public ActionResult List()
        {
            IEnumerable<Department> list = iDepartment.List();
            return PartialView(list);
        }
        

        // GET: GeneralManagement/Department/Create
        public ActionResult Create()
        {
            return PartialView(new Department());
        }

        // POST: GeneralManagement/Department/Create
        [HttpPost]
        public ActionResult Create(Department obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iDepartment.Update(obj, "i");
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

        // GET: GeneralManagement/Department/Edit/5
        public ActionResult Edit(string id)
        {
            Department obj = iDepartment.GetById(id);
            return PartialView(obj);
        }

        // POST: GeneralManagement/Department/Edit/5
        [HttpPost]
        public ActionResult Edit(Department obj)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    var result = iDepartment.Update(obj, "u");
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

       

        // POST: GeneralManagement/Department/Delete/5
        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                var result = iDepartment.Delete(id);
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
