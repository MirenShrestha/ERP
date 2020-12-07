using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class PaySlip : BaseModel
    {
        public int Id { get; set; }
        
        [Required]
        public int EmployeeId { get; set; }
        [Required]
        public string Year { get; set; }
        [Required]
        public string Month { get; set; }
        [Required]
        public decimal TotalEarnings { get; set; }
        [Required]
        public decimal TotalDeduction { get; set; }
        [Required]
        public decimal NetPay { get; set; }


    }
}
