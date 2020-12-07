using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.GeneralManagement
{
    public class Settings : BaseModel
    {
        public int Id { get; set; }
        [Required]
        public decimal TaxPercentage { get; set; }
        [Required]
        public string TaxType { get; set; }

    }
}
