using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.GeneralManagement
{
    public class Agents : BaseModel
    {
        public int Id { get; set; }
        [Required]
        
        public string Name { get; set; }
        [Required]
        
        public string Address { get; set; }
        public string ContactPerson { get; set; }

        [Required]
        //[RegularExpression("([0-9]+)", ErrorMessage = "Please enter valid Number")]
        public string Telephone { get; set; }
        
        [Required]
        //[Range(0, float.MaxValue, ErrorMessage = "Please enter valid Number")]
        public decimal CommissionPercentage { get; set; }
        
        [Required]
        public string VATPAN { get; set; }

    }
}
