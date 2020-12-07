using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.TicketingManagement
{
    public class TicketRateVM
    {
        public int Id { get; set; }
        public int Code { get; set; }
        public string Name { get; set; }
        public string Currency { get; set; }
        public decimal BaseRate { get; set; }
        public decimal LocalTax { get; set; }
        public decimal VAT { get; set; }
        public decimal Total { get; set; }
        public decimal RoundOff { get; set; }
        public decimal GrandTotal { get; set; }

        public string Category { get; set; }
        public string Type { get; set; }
        public string Package { get; set; }
        public bool IsActive { get; set; }

    }

}
