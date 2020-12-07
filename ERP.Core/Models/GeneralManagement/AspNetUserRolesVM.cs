using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Core.Models.GeneralManagement
{
    public class AspNetUserRolesVM : AspNetUserRoles
    {
        public string User { get; set; }
        public string Role { get; set; }

    }
}
