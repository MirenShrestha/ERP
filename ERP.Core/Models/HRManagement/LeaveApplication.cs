using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class LeaveApplication
    {
        
        public int Id { get; set; }
        [Required(ErrorMessage ="The field Employee is required.")]
        public int EmpId { get; set; }

        [Required(ErrorMessage = "The field Department is required.")]
        public int DepartmentId { get; set; }

        [Required(ErrorMessage = "The field StartDate is required.")]
        public DateTime StartDate { get; set; }

        [Required(ErrorMessage = "The field EndDate is required.")]
        public DateTime EndDate { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }

        [Required(ErrorMessage = "The field Remarks is required.")]
        public string Remarks { get; set; }

        [Required(ErrorMessage = "The field LeaveType is required.")]
        public string LeaveType { get; set; }

        [Required(ErrorMessage = "The field Reason is required.")]
        public string Reason { get; set; }
        public string Status { get; set; }
    }
}
