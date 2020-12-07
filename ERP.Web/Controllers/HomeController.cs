using ERP.Common.Helper;
using ERP.Core.Models.UserManagement;
using ERP.Service.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
           // return RedirectToAction("CalendarDashboard", "Calendar", new { area = "MaintenanceManagement" });
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult MenuPage()
        {
            ViewBag.Message = "Your contact page.";

            return PartialView();
        }

        public ActionResult Profile()
        {
            return View();
        }

        public ActionResult LogOff()
        {
            Session.Abandon();
            Session.RemoveAll();
            Session.Clear();
            return RedirectToAction("Login", "Account");
        }

    }
}