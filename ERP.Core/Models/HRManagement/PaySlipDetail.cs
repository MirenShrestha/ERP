using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.HRManagement
{
    public class PaySlipDetail
    {
        public int PayId { get; set; }
        public int EarningId { get; set; }
        public int DeductionId { get; set; }
        public decimal EarningAmount { get; set; }
        public decimal DedictionAmount { get; set; }

    }
}
