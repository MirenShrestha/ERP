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
    public class CategoryService : ICategoryService
    {
        CategoryRepository repo = null;
        public CategoryService()
        {
            repo = new CategoryRepository();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public Category GetById(string id)
        {
            return repo.GetById(id);
        }

        public IEnumerable<Category> List()
        {
            return repo.List();
        }

        public IEnumerable<Category> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(Category entity, string flag)
        {
            return repo.Update(entity,flag);
        }
    }
}
