using System;
using System.ComponentModel.DataAnnotations;

namespace ERP.Core.Models.GeneralManagement
{
    public class Shift : BaseModel
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string StartTime { get; set; }

        [Required]
        public string EndTime { get; set; }
    }
}
