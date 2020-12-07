using System.Web.Mvc;

namespace ERP.Web.Areas.GeneralManagement
{
    public class GeneralManagementAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "GeneralManagement";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "GeneralManagement_default",
                "GeneralManagement/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
              new[] { "ERP.Web.Areas.GeneralManagement.Controllers" }

            );
        }
    }
}