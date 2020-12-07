using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.TicketingManagement
{
    public class Package
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="The Name field is required.")]
        public string Name { get; set; }
        [Required(ErrorMessage ="The code field is required.")]
        public string Code { get; set; }

    }
}
