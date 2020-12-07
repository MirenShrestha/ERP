using System;

namespace ERP.Common.Localization
{
    public class Text : IText
    {
        private readonly string _scope;
        public Text(string scope)
        {
            _scope = scope;

        }

        public LocalizedString Get(string textHint, params object[] args)
        {
            throw new NotImplementedException();
        }
    }
}
