using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.UserManagement
{
    public class Role : BaseModel
    {
        public string Id { get; set; }
        [Required(ErrorMessage = "Role name is required")]
        public string Name { get; set; }
    }
}
