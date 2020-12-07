using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class Promotion
    {
        public int Id { get; set; }

        public int EmployeeId  { get; set; }
        [Required]
        public int DepartmentId { get; set; }
        [Required]
        public int DesignationId { get; set; }
        [Required]
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        [Required]
        public string Salary { get; set; }

        public string UserId { get; set; }


    }
}
