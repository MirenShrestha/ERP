using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Interfaces.TicketingManagement
{
    public interface ITicketRateService : IBaseService<TicketRate, string, DbResult>
    {
        List<TicketRateVM> List(bool Active = false);
    }
}
