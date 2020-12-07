using ERP.Core.Models;
using ERP.Core.Models.HRManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Interfaces.HRManagement
{
    public interface ILeaveService : IBaseService<LeaveApplication, string, DbResult>
    {
        List<LeaveApplicationVM> AllList();
        DbResult LeaveAction(string Id, string type);
    }
}
