﻿using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Interfaces.GeneralManagement
{
    public interface IRoleManagementService : IBaseService<AspNetUserRoles, string, DbResult>
    {
        List<AspNetUserRolesVM> ListAll(bool Active = false);
    }
}