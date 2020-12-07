using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.TicketingManagement
{
    public class Denomination
    {
        public int Id { get; set; }
        public decimal Rs1000 { get; set; }
        public decimal Rs500 { get; set; }
        public decimal Rs100 { get; set; }
        public decimal Rs50 { get; set; }
        public decimal Rs20 { get; set; }
        public decimal Rs10 { get; set; }
        public decimal Rs5 { get; set; }
        public decimal Coins { get; set; }
        public decimal IC { get; set; }
        public int FyId { get; set; }

        public int UserId { get; set; }
        public string SettlementRequest { get; set; }
        public string Impression { get; set; }
        public string SettledBy { get; set; }

        [Required]
        public string Remarks { get; set; }
        public int Status { get; set; }

        public List<DenominationGraph> GraphList;
    }
}
