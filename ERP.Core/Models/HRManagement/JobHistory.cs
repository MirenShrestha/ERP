using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class JobHistory : BaseModel
    {
        public int Id { get; set; }
        public int EmpId { get; set; }
        public int DesignationId { get; set; }
        public int DepartmentId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Salary { get; set; }
        public string OTRate { get; set; }
        public decimal WorkingHR { get; set; }
        public string PaySchedule { get; set; }
        public bool IsCurrent { get; set; }

    }
}
