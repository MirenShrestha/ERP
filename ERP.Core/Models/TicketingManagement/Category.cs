using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.TicketingManagement
{
    public class Category : BaseModel
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="The Name field is required.")]
        public string Name { get; set; }
        [Required(ErrorMessage ="The Unit(e.g PAX) field is required.")]
        public string Unit { get; set; }
        [Required(ErrorMessage ="The ShortName field is required.")]
        public string ShortName { get; set; }

    }
}
