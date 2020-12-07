using ERP.Core.Models;
using ERP.Core.Models.HRManagement;
using ERP.Data.Repositories.HRManagement;
using ERP.Service.Interfaces.HRManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Services.HRManagement
{
    public class EmployeeService : IEmployeeService
    {
        EmployeeRepository repo;
        public EmployeeService()
        {
            repo = new EmployeeRepository();
        }

        public EmployeeDetailsVM EmployeeDetails(string empId)
        {
            return repo.EmployeeDetails(empId);
        }

        public DbResult FireEmployee(string Id)
        {
            return repo.FireEmployee(Id);
        }

        public EmploymentDetails GetJobById(string Id)
        {
            return repo.GetJobById(Id);
        }

        public Promotion GetJobDetailsById(string EmpId)
        {
            return repo.GetJobDetailsById(EmpId);
        }

        public PayDetails GetPayDetailById(string Id)
        {
            return repo.GetPayDetailById(Id);
        }

        public EmployeeDetails GetPersonalById(string Id)
        {
            return repo.GetPersonalById(Id);
        }

        public string ImagePathById(string Id)
        {
            return repo.ImagePathById(Id);
        }

        public List<EmployeeViewModel> List()
        {
            return repo.List();
        }

        public DbResult Update(EmployeeDetails entity, string flag)
        {
            return repo.Update(entity, flag);
        }

        public DbResult UpdateEmployment(EmploymentDetails obj, string flag)
        {
            return repo.UpdateEmployment(obj, flag);
        }

        public DbResult UpdateJob(Promotion obj, string flag)
        {
            return repo.UpdateJob(obj, flag);
        }

        public DbResult UpdatePayDetails(PayDetails obj, string flag)
        {
            return repo.UpdatePayDetails(obj, flag);
        }

        public DbResult UploadProfile(int Id, string filePath)
        {
            return repo.UploadProfile(Id,filePath);
        }
    }
}
