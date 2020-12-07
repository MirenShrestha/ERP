using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using System;

namespace ERP.Service.Interfaces.TicketingManagement
{
    public interface ICounterSettlementService 
    {
        Denomination CounterSettlement(string userId, DateTime date);
        DbResult Settle(Denomination obj);
    }
}
