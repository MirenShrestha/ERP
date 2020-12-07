using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class JobHistoryVM
    {
        public string Designation { get; set; }
        public string Department { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string Shift { get; set; }
        public string EmployementType { get; set; }
        public string Salary { get; set; }
        public string OTRate { get; set; }
        public string WorkingHR { get; set; }
        public string ContractExpiry { get; set; }
        public string PaySchedule { get; set; }
        public bool IsCurrent { get; set; }
    }
}
