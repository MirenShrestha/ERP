using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.TicketingManagement
{
    public class DenominationGraph
    {
        public string PaymentMode { get; set; }

        //[DisplayFormat(DataFormatString = "{0:#.####}")]
        public decimal GrandTotal { get; set; }

    }
}
