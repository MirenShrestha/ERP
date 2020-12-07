using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class EmployeeDetails : BaseModel
    {
        public int Id { get; set; }
        [Required]
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        [Required]
        public string LastName { get; set; }

        [Required]
        public string Gender { get; set; }

        [Required]
        public string Phone { get; set; }

        [Required]
        public string Nationality { get; set; }
        public DateTime DOB { get; set; }

        [Required]
        public string MaritalStatus { get; set; }
        public string Ethnicity { get; set; }

        [Required]
        public string Address { get; set; }
        public string Email { get; set; }
        public string BasicSalary { get; set; }
        public int DepartmentId { get; set; }
        public int DesignationId { get; set; }
        public DateTime StartDate { get; set; }
        public int ShiftId { get; set; }
        public int EmploymentTypeId { get; set; }
        public string ContractFileName { get; set; }
        public string ProfilePath { get; set; }
        public DateTime ContractExpiry { get; set; }
        public string BankName { get; set; }
        public string BankBranch { get; set; }
        public string AccountNo { get; set; }
        public string AccountName { get; set; }
        public bool IsSuspended { get; set; }
        public bool IsFired { get; set; }

        [Required]
        public int DistrictId { get; set; }
        [Required]
        public int StateId { get; set; }


    }
}
