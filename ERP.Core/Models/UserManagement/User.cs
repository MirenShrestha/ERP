using System;
using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.UserManagement
{
    public class User:BaseModel
    {
        public string Id { get; set; }

        [RegularExpression("^[0-9]*$", ErrorMessage = "The Phone must be numeric.")]
        public string Phone { get; set; }
        
        [Required]
        [RegularExpression("^[0-9]*$", ErrorMessage = "The Mobile must be numeric.")]
        public string Mobile { get; set; }
       
        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Display(Name = "Middle Name")]
        public string MiddleName { get; set; }
        
        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        
        [Required]
        public string Gender { get; set; }
      
        public DateTime? DOB { get; set; } 
        public int? State { get; set; }
        public int? District { get; set; }
        public int? VdcMunc { get; set; }
        public string City { get; set; }
        public string Address { get; set; }

        [Display(Name = "Ward No")]
        public int? WardNo { get; set; }
        public string UserName { get; set; }
       
        public string FullName { get ; set; }

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

        public string RoleId { get; set; }

        public int EmployeeId { get; set; }
    }
}
