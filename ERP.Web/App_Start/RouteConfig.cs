﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ERP.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


            routes.MapRoute(
               name: "Default",
               url: "{controller}/{action}/{id}",
               defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
               namespaces: new[] { "ERP.Web.Controllers" }
           ).DataTokens["UseNamespaceFallback"] = false;

            

            //routes.MapRoute(
            //         name: "normal_def",
            //         url: "{controller}/{action}/{id}",
            //         defaults: new { controller = "Role", action = "Index", id = UrlParameter.Optional },
            //         namespaces: new[] { "ERP.Web.Controllers" }
            //    ).DataTokens["UseNamespaceFallback"] = false;

            //routes.MapRoute(
            //    name: "normal",
            //    url: "{*url}",
            //    defaults: new { controller = "Staff", action = "Index", id = UrlParameter.Optional },
            //    namespaces: new[] { "ERP.Web.Controllers" }
            //).DataTokens["UseNamespaceFallback"] = false; 

        }
    }
}
