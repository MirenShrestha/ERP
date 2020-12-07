using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class PayDetails
    {
        public int Id { get; set; }
        public int EmployeeId { get; set; }

        [Required]
        public string BasicSalary { get; set; }
        public string OTRate { get; set; }
        public decimal WorkingHR { get; set; }
        public string PaySchedule { get; set; }
        public bool IsCurrent { get; set; }
        public string BankName { get; set; }
        public string BankBranch { get; set; }
        public string AccountNo { get; set; }
        public string AccountName { get; set; }

    }
}
