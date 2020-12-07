using ERP.Common.Localization;

namespace ERP.Common.Mvc.ViewEngine
{
  
    public abstract class CustomWebViewPage<TModel> : System.Web.Mvc.WebViewPage<TModel>, IViewPage
    {
        private readonly Localizer _localize = NullLocalizer.Instance;
        public Localizer L
        {
            get { return _localize; }
        }
  
    }
}
