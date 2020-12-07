using ERP.Web.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Controllers
{
  
    [Authorize]
    [SessionExpireFilter]
    //[NoCache]
    public class BaseController : Controller
    {
        // GET: Base
     public  BaseController ()
        {

        }

     protected override void OnActionExecuting(ActionExecutingContext filterContext)
     {
         ViewBag.Layout = "~/Views/Shared/_Layout.cshtml";
         //SetCulture();
     }
           
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (!Request.IsAuthenticated)
            {
                filterContext.Result = RedirectToAction("Login", "Account"); // your login related pages
            }
        }

        //private void SetCulture()
        //{
        //    string language = CultureHelper.GetImplementedCulture((RouteData.Values["locale"].ToString()));
        //    CultureInfo ci = CultureInfo.GetCultureInfo(language);
        //    Thread.CurrentThread.CurrentCulture = ci;
        //    Thread.CurrentThread.CurrentUICulture = ci;
        //}
    }
}