using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ERP.Core.Models.Common
{
    public class ApplicationLog
    {
        public int Id { get; set; }
        public string ErrorPage { get; set; }
        public string ErrorMsg { get; set; }
        public string ErrorDetails { get; set; }
        public string IpAddress { get; set; }
        public string Referer { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }

    }
}