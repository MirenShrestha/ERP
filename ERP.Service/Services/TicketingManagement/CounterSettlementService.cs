using ERP.Core.Models;
using ERP.Core.Models.TicketingManagement;
using ERP.Data.Repositories.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.TicketingManagement
{
    public class CounterSettlementService : ICounterSettlementService
    {
        CounterSettlementRepository repo;
        public CounterSettlementService()
        {
            repo = new CounterSettlementRepository();
        }
        public Denomination CounterSettlement(string userId, DateTime date)
        {
            return repo.CounterSettlement(userId,date);
        }

        public DbResult Settle(Denomination obj)
        {
            return repo.Settle(obj);
        }
    }
}
