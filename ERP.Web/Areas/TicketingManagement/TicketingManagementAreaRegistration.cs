using System.Web.Mvc;

namespace ERP.Web.Areas.TicketingManagement
{
    public class TicketingManagementAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "TicketingManagement";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "TicketingManagement_default",
                "TicketingManagement/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}