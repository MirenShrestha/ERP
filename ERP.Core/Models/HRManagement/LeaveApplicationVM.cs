using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class LeaveApplicationVM
    {

        public int Id { get; set; }
        public string EmployeeName { get; set; }
        public string Department { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Remarks { get; set; }
        public string LeaveType { get; set; }

        public string Reason { get; set; }
        public string Status { get; set; }
    }
}
