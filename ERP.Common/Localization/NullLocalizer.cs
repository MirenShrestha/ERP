using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Common.Localization
{
    public static class NullLocalizer
    {
        private static readonly Localizer _instance;
        public static Localizer Instance { get { return _instance; } }
        static NullLocalizer()
        {
            _instance = (format, args) => new LocalizedString((args == null || args.Length == 0) ? format : string.Format(format, args));
        }
    }


}
