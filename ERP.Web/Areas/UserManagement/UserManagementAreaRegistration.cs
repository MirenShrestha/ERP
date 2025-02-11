﻿using System.Web.Mvc;

namespace ERP.Web.Areas.UserManagement
{
    public class UserManagementAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "UserManagement";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "UserManagement_default",
                "UserManagement/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                new[] { "ERP.Web.Areas.UserManagement.Controllers" }
            );
        }
    }
}