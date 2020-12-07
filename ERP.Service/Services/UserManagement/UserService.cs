using ERP.Service.Interfaces.UserManagement;
using System.Collections.Generic;
using ERP.Core.Models;
using ERP.Core.Models.UserManagement;
using ERP.Data.Repositories.UserManagement;
using System;

namespace ERP.Service.Services.UserManagement
{
    public class UserService : IUserService
    {
        UserRepository repo = null;
        public UserService()
        {
            repo = new UserRepository();
        }

        public DbResult Delete(string id)
        {
            return repo.Delete(id);
        }

        public User GetById(string id)
        {
            return repo.GetById(id);
        }

        public List<ViewModelRole> GetRolesByUserId(string id)
        {
            return repo.GetRolesByUserId(id);
        }

       

        public IEnumerable<User> List()
        {
            return repo.List();
        }

        public IEnumerable<User> ListActive()
        {
            return repo.List(true);
        }

        public DbResult Update(User entity, string flag)
        {
            return repo.Update(entity, flag);
        }

        public DbResult UpdateUser(Register obj)
        {
            return repo.UpdateUser(obj);
        }
    }
}
