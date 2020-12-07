using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class EmploymentDetails
    {
        public int Id { get; set; }

        public int EmployeeId { get; set; }

        [Required]
        public int DistrictId { get; set; }
        [Required]
        public int DepartmentId { get; set; }

        [Required]
        public int JobId { get; set; }

        [Required]
        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        [Required]
        public int ShiftId { get; set; }

        [Required]
        public int EmploymentTypeId { get; set; }

        public string ContractFile { get; set; }

        public DateTime ContractExpiry { get; set; }


    }
}
