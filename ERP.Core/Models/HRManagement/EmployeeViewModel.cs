using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class EmployeeViewModel : BaseModel
    {
        public int EmpId { get; set; }
        public string FullName { get; set; }
        public string Department { get; set; }
        public string Designation { get; set; }
        public string EmploymentType { get; set; }

        public string Gender { get; set; }
        public string Phone { get; set; }
        public string Nationality { get; set; }
        public DateTime DOB { get; set; }
        public string MaritalStatus { get; set; }
        public string Ethnicity { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public DateTime StartDate { get; set; }

        public string District { get; set; }


        public string ContractFilePath { get; set; }
        public DateTime ContractExpiry { get; set; }
        
        public bool IsCurrent { get; set; }
    }
}
