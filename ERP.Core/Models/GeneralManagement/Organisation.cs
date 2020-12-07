using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.GeneralManagement
{
    public class Organisation : BaseModel
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Address { get; set; }
        [Required]
        public int ContactNo { get; set; }
        [Required]
        public string VatPan { get; set; }

    }
}
