using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.UserManagement
{
    public class Register:BaseModel
    {

        public string Id { get; set; }


        [Required(ErrorMessage="The field Employee is required.")]
        public int EmployeeId { get; set; }

        [Required(ErrorMessage="The field UserName is required.")]
        public string UserName { get; set; }

        [Required(ErrorMessage="The field Role is required.")]
        public string RoleId { get; set; }

        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }


    }
}
