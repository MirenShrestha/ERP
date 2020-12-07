using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.TicketingManagement
{
    public class TicketRate : BaseModel
    {
        public int Id { get; set; }
        [Required]
        public int Code { get; set; }

        [Required(ErrorMessage ="The Category field is required.")]
        public int CategoryId { get; set; }
        
        [Required(ErrorMessage ="The Name field is required.")]
        public string Name { get; set; }

        [Required(ErrorMessage ="The Type field is required.")]
        public int TypeId { get; set; }

        [Required(ErrorMessage ="The Package field is required.")]
        public int PackageId { get; set; }

        [Required(ErrorMessage ="The Currency field is required.")]
        public string Currency { get; set; }

        [Required(ErrorMessage ="The BaseRate field is required.")]
        public decimal BaseRate { get; set; }

        [Required(ErrorMessage ="The LocalTax field is required.")]
        public decimal LocalTax { get; set; }

        [Required(ErrorMessage = "The VAT field is required.")]
        public decimal VAT { get; set; }

        [Required(ErrorMessage = "The TOTAL field is required.")]
        public decimal Total { get; set; }

        [Required(ErrorMessage = "The RoundOff field is required.")]
        public decimal RoundOff { get; set; }

        [Required(ErrorMessage = "The GrandTotal field is required.")]
        public decimal GrandTotal { get; set; }

    }
}
