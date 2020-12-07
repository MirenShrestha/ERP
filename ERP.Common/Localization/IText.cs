using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Common.Localization
{
    public interface IText
    {
        LocalizedString Get(string textHint, params object[] args);
    }

}
