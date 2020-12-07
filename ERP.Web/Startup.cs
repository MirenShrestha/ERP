using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ERP.Web.Startup))]
namespace ERP.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
