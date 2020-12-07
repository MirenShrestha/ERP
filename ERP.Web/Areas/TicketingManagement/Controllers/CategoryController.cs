using ERP.Core.Models.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.TicketingManagement.Controllers
{
    public class CategoryController : BaseController
    {

        ICategoryService iCategory;
        public CategoryController(ICategoryService categoryService)
        {
            iCategory = categoryService;
        }

        // GET: TicketingManagement/Category
        public ActionResult Index()
        {
            return PartialView();
        }
        public ActionResult List()
        {
            IEnumerable<Category> lst = iCategory.List();
            return PartialView(lst);
        }

        public ActionResult Create()
        {
            return PartialView(new Category());
        }

        [HttpPost]
        public ActionResult Create(Category obj)
        {
            if (ModelState.IsValid)
            {
                try
                {

                    var result = iCategory.Update(obj, "i");
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
            Category obj = iCategory.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(Category obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iCategory.Update(obj, "u");
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
                var result = iCategory.Delete(id);
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