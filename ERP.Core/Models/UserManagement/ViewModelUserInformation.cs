using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.UserManagement
{
    public class ViewModelUserInformation
    {
        public string UserId { get; set; }
        public string FullName { get; set; }
        public string CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string CompanyCode { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public int? SessionTimeOut { get; set; }
        public DateTime? DOB { get; set; }
        public string Gender { get; set; }
        public string FiscalCode { get; set; }
    }
}
