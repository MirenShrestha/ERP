
using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.TicketingManagement
{
    public class Station : BaseModel
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="The Name field is required.")]
        public string Name { get; set; }  
    }
}
