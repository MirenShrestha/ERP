using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class EmployeeDetailsVM
    {
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }

        public string Gender { get; set; }
        public string Phone { get; set; }
        public string Nationality { get; set; }
        public DateTime? DOB { get; set; }
        public string MaritalStatus { get; set; }
        public string Ethnicity { get; set; }
        public string Province { get; set; }
        public string District { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string BasicSalary { get; set; }
        public string ProfilePath { get; set; }
        public string ContractFile { get; set; }
        public string BankName { get; set; }
        public string BankBranch { get; set; }
        public string AccountNo { get; set; }
        public string AccountName { get; set; }
        public DateTime StartDate { get; set; }

        public List<JobHistoryVM> jobList = new List<JobHistoryVM>();
    }
}
