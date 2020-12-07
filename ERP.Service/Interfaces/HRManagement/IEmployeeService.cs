using ERP.Core.Models;
using ERP.Core.Models.HRManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Service.Interfaces.HRManagement
{
    public interface IEmployeeService 
    {
        DbResult Update(EmployeeDetails entity, string flag);
        DbResult UpdatePayDetails(PayDetails obj, string flag);
        DbResult UpdateEmployment(EmploymentDetails obj, string flag);
        List<EmployeeViewModel> List();
        EmployeeDetails GetPersonalById(string Id);
        PayDetails GetPayDetailById(string Id);
        EmploymentDetails GetJobById(string Id);
        Promotion GetJobDetailsById(string EmpId);
        DbResult UpdateJob(Promotion obj, string flag);
        DbResult FireEmployee(string Id);
        DbResult UploadProfile(int Id, string filePath);
        string ImagePathById(string Id);
        EmployeeDetailsVM EmployeeDetails(string empId);
    }
}
