using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace ERP.Core.Models
{
    public abstract class BaseModel
    {
        public string CreatedBy { get; set; }

        public DateTime? CreatedDate { get; set; }

        public string ApprovedBy { get; set; }

        public DateTime? ApprovedDate { get; set; }

        public string ModifiedBy { get; set; }

        public DateTime ModifiedDate { get; set; }

        public bool IsActive { get; set; }

        public bool IsDeleted { get; set; }

        public short Status { get; set; }

        [NotMapped]
        public string Actions { get; set; }

        [StringLength(20)]
        [NotMapped]
        public string Culture { get; set; }
    }
}
