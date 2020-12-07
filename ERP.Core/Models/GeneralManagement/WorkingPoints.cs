using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.GeneralManagement
{
    public class WorkingPoints : BaseModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }

    }
}
