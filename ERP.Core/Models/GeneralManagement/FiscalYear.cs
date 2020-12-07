using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.GeneralManagement
{
    public class FiscalYear : BaseModel
    {
        public int Id { get; set; }
        [Required]
        public string ShortName { get; set; }
        [Required]
        public string YearCode { get; set; }
        [Required]
        public DateTime StartDate { get; set; }
        [Required]
        public DateTime EndDate { get; set; }

    }
}
