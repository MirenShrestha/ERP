using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Service.Services;
using System;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;

namespace ERP.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {

     
        //public MvcApplication(ICommonLibraryService AppService)
        //{
        //    iAppService = AppService;
        //}

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            //Remove all view engine
            ViewEngines.Engines.Clear();

          

            ////Add Razor view Engine
            //ViewEngines.Engines.Add(new RazorViewEngine());
            //DocuViewareManager.SetupConfiguration();
            //DocuViewareLicensing.RegisterKEY("02b8521f3e154605a1d55b7fb41eb89fd4b3289049d8b12aGx4ZcGz7zE8pzwYyLtCWhhqcW/TElpE8vdNooePcDI5/eFimqlbgw4626xZ5akP8");
            //Add Custom view Engine Derived from Razor
            ViewEngines.Engines.Add(new CSharpRazorViewEngine());

            // iAppService = AppService;
            AntiForgeryConfig.SuppressXFrameOptionsHeader = true;

        }


        protected void Session_Start()
        {
            if (Session["userName"] != null)
            {
                this.Response.RedirectToRoute("Default", new { controller = "Home", action = "Index" });
            }
        }
        protected void Session_End()
        {
            //&User.Identity.IsAuthenticated
            if (Session.IsNewSession)
            {

                SessionHelper.DestroySession();
                FormsAuthentication.SignOut();
            }

            // Remove user from HashTable
        }
        string GetAbsoluteUri(Uri uri)
        {
            try
            {
                if (string.IsNullOrEmpty(uri.OriginalString))
                    return "";

                return uri.AbsoluteUri;
            }
            catch (Exception)
            {
                return "";
            }
        }

        protected void Application_Error()
        {
            var err = Server.GetLastError() as Exception;
            string errorId = string.Empty;
            var dr = new DbResult();
            if (err != null)
            {
                var page = HttpContext.Current.Request.Url.ToString();
                var urlReferrer = HttpContext.Current.Request.UrlReferrer;
                HttpException httpException = err as HttpException;
                string errorCode = string.Empty;
                string errDetails = string.Empty;
                if (httpException != null) // keep record of HttpException
                {
                    int httpCode = httpException.GetHttpCode();

                    errorCode = Convert.ToString(httpCode);
                    errorId = Convert.ToString(errorCode);
                    errDetails = GlobalHelper.FilterString(httpException.GetHtmlErrorMessage());
                }

                CommonLibraryService commonLibraryService = new CommonLibraryService();

                if (Session["userName"]!=null && (errorCode!="500" || errorCode != "501"|| errorCode != "502"|| errorCode != "503"))
                dr = commonLibraryService.LogError(err, page, GetAbsoluteUri(urlReferrer));

                
                Server.ClearError();

                if (!string.IsNullOrEmpty(dr.Id) && dr.Id != "0")
                    errorId =dr.Id.ToString();
                Application["code"] = errorId + '|' + errorCode.ToString();
                this.Response.RedirectToRoute("Default", new { controller = "Error", action = "Error" });
            }
        }
    }
}
