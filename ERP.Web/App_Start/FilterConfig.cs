using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;

namespace ERP.Web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }




        //[AttributeUsage(AttributeTargets.Method, Inherited = true, AllowMultiple = false)]
        //public class SessionExpireFilterAttribute : ActionFilterAttribute
        //{
        //    public override void OnActionExecuting(ActionExecutingContext filterContext)
        //    {
        //        HttpContext context = HttpContext.Current;
        //        if (context.Session != null)
        //        {
        //            if (context.Session.IsNewSession)
        //            {
        //                string sessionCookie = context.Request.Headers["Cookie"];

        //                if ((sessionCookie != null) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0))
        //                {
        //                    FormsAuthentication.SignOut();
        //                    string redirectTo = "~/Account/Login";
        //                    if (!string.IsNullOrEmpty(context.Request.RawUrl))
        //                    {
        //                        redirectTo = string.Format("~/Account/Login?ReturnUrl={0}", HttpUtility.UrlEncode(context.Request.RawUrl));
        //                        filterContext.Result = new RedirectResult(redirectTo);
        //                        return;
        //                    }

        //                }
        //            }
        //        }

        //        base.OnActionExecuting(filterContext);
        //    }
        //}





        //[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = false)]
        //public class SessionExpireFilterAttribute : ActionFilterAttribute
        //{
        //    public override void OnActionExecuting(ActionExecutingContext filterContext)
        //    {
        //        string controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower().Trim();
        //        string actionName = filterContext.ActionDescriptor.ActionName.ToLower().Trim();
        //        if (!actionName.StartsWith("Login") && !actionName.StartsWith("LogOff"))
        //        {
        //            var session = HttpContext.Current.Session["SelectedSiteName"];
        //            HttpContext ctx = HttpContext.Current;
        //            //Redirects user to login screen if session has timed out
        //            if (session == null)
        //            {
        //                base.OnActionExecuting(filterContext);
        //                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
        //                {
        //                    controller = "Account",
        //                    action ="Login"// "SessionLogOff",
        //                }));
        //            }
        //        }
        //    }
        //}


      
        //[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = false)]
        //public sealed class CacheControlAttribute : ActionFilterAttribute
        //{
        //    private readonly HttpCacheability cacheability;
        //    public HttpCacheability Cacheability { get { return this.cacheability; } }
        //    public CacheControlAttribute(HttpCacheability cacheability)
        //    {
        //        this.cacheability = cacheability;
        //    }
        //    public override void OnActionExecuted(ActionExecutedContext filterContext)
        //    {
        //        HttpCachePolicyBase cache = filterContext.HttpContext.Response.Cache;
        //        cache.SetCacheability(this.cacheability);
        //    }
        //}
    }



    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class SessionExpireFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContext ctx = HttpContext.Current;

            // If the browser session or authentication session has expired...
            if (ctx.Session["userName"] == null || !filterContext.HttpContext.Request.IsAuthenticated)
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    // For AJAX requests, we're overriding the returned JSON result with a simple string,
                    // indicating to the calling JavaScript code that a redirect should be performed.
                    filterContext.Result = new JsonResult { Data = "_Logon_" };
                }
                else
                {
                    // For round-trip posts, we're forcing a redirect to Home/TimeoutRedirect/, which
                    // simply displays a temporary 5 second notification that they have timed out, and
                    // will, in turn, redirect to the logon page.
                    //filterContext.Result = new RedirectToRouteResult(
                    //    new RouteValueDictionary {
                    //{ "Controller", "Account" },
                    //{ "Action", "Login" }
                    //});
                    ctx.Response.RedirectPermanent("~/Account/Login", false);
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class LocsAuthorizeAttribute : AuthorizeAttribute
    {
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            HttpContext ctx = HttpContext.Current;

            // If the browser session has expired...
            if (ctx.Session["userName"] == null)
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    // For AJAX requests, we're overriding the returned JSON result with a simple string,
                    // indicating to the calling JavaScript code that a redirect should be performed.
                    filterContext.Result = new JsonResult { Data = "_Logon_" };
                }
                else
                {
                    // For round-trip posts, we're forcing a redirect to Home/TimeoutRedirect/, which
                    // simply displays a temporary 5 second notification that they have timed out, and
                    // will, in turn, redirect to the logon page.
                    filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary {
                        { "Controller", "Account" },
                        { "Action", "Login" }
                    });
                }
            }
            else if (filterContext.HttpContext.Request.IsAuthenticated)
            {
                // Otherwise the reason we got here was because the user didn't have access rights to the
                // operation, and a 403 should be returned.
                filterContext.Result = new HttpStatusCodeResult(403);
            }
            else
            {
                base.HandleUnauthorizedRequest(filterContext);
            }
        }
    }
    public class NoCacheAttribute : ActionFilterAttribute
    {
        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            if (filterContext == null) throw new ArgumentNullException("filterContext");

            var cache = GetCache(filterContext);

            cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            cache.SetValidUntilExpires(false);
            cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            cache.SetCacheability(HttpCacheability.NoCache);
            cache.SetNoStore();

            base.OnResultExecuting(filterContext);
        }

        protected virtual HttpCachePolicyBase GetCache(ResultExecutingContext filterContext)
        {
            return filterContext.HttpContext.Response.Cache;
        }
    }
}
