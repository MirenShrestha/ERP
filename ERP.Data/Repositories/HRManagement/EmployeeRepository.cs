using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.HRManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ERP.Data.Repositories.HRManagement
{
    public class EmployeeRepository
    {
        public DbResult Update(EmployeeDetails obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@FirstName", SqlDbType.VarChar, 50) { Value = obj.FirstName}
                                    ,new SqlParameter("@MiddleName", SqlDbType.VarChar, 30) { Value = obj.MiddleName}
                                    ,new SqlParameter("@LastName", SqlDbType.VarChar, 30) { Value = obj.LastName}
                                    ,new SqlParameter("@Gender", SqlDbType.VarChar, 20) { Value = obj.Gender}
                                    ,new SqlParameter("@Phone", SqlDbType.VarChar, 20) { Value = obj.Phone}

                                    ,new SqlParameter("@Nationality", SqlDbType.VarChar, 20) { Value = obj.Nationality}
                                    ,new SqlParameter("@DOB", SqlDbType.Date) { Value = obj.DOB}
                                    ,new SqlParameter("@MaritalStatus", SqlDbType.VarChar, 20) { Value = obj.MaritalStatus}
                                    ,new SqlParameter("@Ethnicity", SqlDbType.VarChar, 30) { Value = obj.Ethnicity}
                                    ,new SqlParameter("@StateId", SqlDbType.Int) { Value = obj.StateId}
                                    ,new SqlParameter("@DistrictId", SqlDbType.Int) { Value = obj.DistrictId}

                                    ,new SqlParameter("@Address", SqlDbType.VarChar,50) { Value = obj.Address}
                                    ,new SqlParameter("@Email", SqlDbType.VarChar,60) { Value = obj.Email}

                                    ,new SqlParameter("@userId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                  };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }
        public DbResult UpdateEmployment(EmploymentDetails obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag }
                                  ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                  ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = obj.EmployeeId}
                                  ,new SqlParameter("@DesignationId", SqlDbType.Int) { Value = obj.JobId}
                                  ,new SqlParameter("@DepartmentId", SqlDbType.Int) { Value = obj.DepartmentId}
                                  ,new SqlParameter("@StartDate", SqlDbType.DateTime) { Value = obj.StartDate}
                                  ,new SqlParameter("@EndDate", SqlDbType.DateTime) { Value = obj.ContractExpiry}
                                  ,new SqlParameter("@ShiftId", SqlDbType.Int) { Value = obj.ShiftId}
                                  ,new SqlParameter("@EmploymentTypeId", SqlDbType.Int) { Value = obj.EmploymentTypeId}
                                  ,new SqlParameter("@ContractFile", SqlDbType.VarChar,50) { Value = obj.ContractFile}

                                  ,new SqlParameter("@userId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }

        public DbResult UpdatePayDetails(PayDetails obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag }
                                  ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                  ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = obj.EmployeeId}

                                  ,new SqlParameter("@BankName", SqlDbType.VarChar,50) { Value = obj.BankName}
                                  ,new SqlParameter("@BankBranch", SqlDbType.VarChar,50) { Value = obj.BankBranch}
                                  ,new SqlParameter("@AccountNo", SqlDbType.VarChar,50) { Value = obj.AccountNo}
                                  ,new SqlParameter("@AccountName", SqlDbType.VarChar,50) { Value = obj.AccountName}
                                  ,new SqlParameter("@BasicSalary", SqlDbType.VarChar,20) { Value = obj.BasicSalary}
                                  ,new SqlParameter("@PaySchedule", SqlDbType.VarChar,20) { Value = obj.PaySchedule}

                                  ,new SqlParameter("@OTRate", SqlDbType.VarChar,20) { Value = obj.OTRate}
                                  ,new SqlParameter("@WorkingHR", SqlDbType.Decimal) { Value = obj.WorkingHR}
                                  ,new SqlParameter("@userId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }


        public List<EmployeeViewModel> List()
        {
            List<EmployeeViewModel> lst = new List<EmployeeViewModel>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a"}
                                   };
            DataTable result = SqlHelper.ExecuteDataTable("spEmployee", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    EmployeeViewModel obj = new EmployeeViewModel();
                    obj.EmpId = Convert.ToInt32(drow["Id"]);

                    obj.FullName = Convert.ToString(drow["Name"]);
                    obj.Department = Convert.ToString(drow["Department"]);
                    obj.Designation = Convert.ToString(drow["Post"]);
                    obj.EmploymentType = Convert.ToString(drow["Type"]);
                    obj.Phone = Convert.ToString(drow["Phone"]);
                    obj.Gender = Convert.ToString(drow["Gender"]);
                    obj.District = Convert.ToString(drow["District"]);
                    obj.Address = Convert.ToString(drow["Address"]);
                    obj.StartDate = Convert.ToDateTime(drow["JoinedDate"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }

        public EmployeeDetailsVM EmployeeDetails(string empId)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "get-details" }
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = empId}
                                   };

            var table = SqlHelper.ExecuteDataSet("spEmployee", param);
            EmployeeDetailsVM obj = new EmployeeDetailsVM();
            List<JobHistoryVM> list = new List<JobHistoryVM>();

            DataTable details = table.Tables[0];
            DataTable history = table.Tables[1];

            if (details != null && details.Rows.Count > 0)
            {

                obj.FirstName = details.Rows[0]["FirstName"].ToString();
                obj.MiddleName = details.Rows[0]["MiddleName"].ToString();
                obj.LastName = details.Rows[0]["LastName"].ToString();
                obj.Gender = details.Rows[0]["Gender"].ToString();
                obj.Phone = details.Rows[0]["Phone"].ToString();
                obj.Nationality = details.Rows[0]["Nationality"].ToString();
                obj.DOB = details.Rows[0]["DOB"] != DBNull.Value ? Convert.ToDateTime(details.Rows[0]["DOB"]) : (DateTime?)null; // Convert.ToDateTime(details.Rows[0]["DOB"]);
                obj.MaritalStatus = details.Rows[0]["MaritalStatus"].ToString();
                obj.Ethnicity = details.Rows[0]["Ethnicity"].ToString();
                obj.Province = Convert.ToString(details.Rows[0]["Province"]);
                obj.District = Convert.ToString(details.Rows[0]["District"]);
                obj.Address = details.Rows[0]["Address"].ToString();
                obj.Email = details.Rows[0]["Email"].ToString();
                obj.BasicSalary = details.Rows[0]["BasicSalary"].ToString();
                obj.ProfilePath = details.Rows[0]["ProfilePath"].ToString();
                obj.ContractFile = details.Rows[0]["ContractFile"].ToString();

                obj.BankName = details.Rows[0]["BankName"].ToString();
                obj.BankBranch = details.Rows[0]["BankBranch"].ToString();
                obj.AccountNo = details.Rows[0]["AccountNo"].ToString();
                obj.AccountName = details.Rows[0]["AccountName"].ToString();
                obj.StartDate = Convert.ToDateTime(details.Rows[0]["StartDate"]);
            }
            if (history != null && history.Rows.Count > 0)
            {
                foreach(DataRow drow in history.Rows)
                {
                    JobHistoryVM job = new JobHistoryVM();

                    job.Designation = Convert.ToString(drow["Designation"]);
                    job.Department = Convert.ToString(drow["Department"]);
                    job.StartDate = Convert.ToDateTime(drow["StartDate"]);
                    job.EndDate = drow["EndDate"] != DBNull.Value? Convert.ToDateTime(drow["EndDate"]) :(DateTime ?) null ;
                    job.Shift = Convert.ToString(drow["Shift"]);
                    job.EmployementType = Convert.ToString(drow["EmployementType"]);
                    job.Salary = Convert.ToString(drow["Salary"]);
                    job.OTRate = Convert.ToString(drow["OTRate"]);
                    job.WorkingHR = Convert.ToString(drow["WorkingHR"]);
                    job.ContractExpiry = Convert.ToString(drow["ContractExpiry"]);

                    job.PaySchedule = Convert.ToString(drow["PaySchedule"]);
                    job.IsCurrent = Convert.ToBoolean(drow["IsCurrent"]);

                    list.Add(job);
                }
            }
            obj.jobList = list;

            return obj;
        }

        public EmployeeDetails GetPersonalById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "getPersonalById" }
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spEmployee", param);
            EmployeeDetails obj = new EmployeeDetails();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.FirstName = result["FirstName"].ToString();
            obj.MiddleName = result["MiddleName"].ToString();
            obj.LastName = result["LastName"].ToString();
            obj.Gender = result["Gender"].ToString();
            obj.Phone = result["Phone"].ToString();
            obj.Nationality = result["Nationality"].ToString();
            obj.DOB = Convert.ToDateTime(result["DOB"]);
            obj.MaritalStatus = result["MaritalStatus"].ToString();
            obj.Ethnicity = result["Ethnicity"].ToString();
            obj.StateId = Convert.ToInt32(result["StateId"]);
            obj.DistrictId = Convert.ToInt32(result["DistrictId"]);
            obj.Address = result["Address"].ToString();
            obj.Email = result["Email"].ToString();

            return obj;
        }

        public EmploymentDetails GetJobById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "getEmploymentById" }
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spEmployee", param);
            EmploymentDetails obj = new EmploymentDetails();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.EmployeeId = Convert.ToInt32(result["EmpId"]);

            obj.JobId = Convert.ToInt32(result["DesignationId"]);
            obj.DepartmentId = Convert.ToInt32(result["DepartmentId"]);
            obj.StartDate = Convert.ToDateTime(result["StartDate"]);
            obj.EndDate = Convert.ToDateTime(result["EndDate"]);
            obj.ShiftId = Convert.ToInt32(result["ShiftId"]);
            obj.EmploymentTypeId = Convert.ToInt32(result["EmploymentTypeId"]);

            obj.ContractExpiry = Convert.ToDateTime(result["ContractExpiry"]);
            obj.ContractFile = Convert.ToString(result["ContractFile"]);

            return obj;
        }

        public PayDetails GetPayDetailById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "getPayById" }
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spEmployee", param);
            PayDetails obj = new PayDetails();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.EmployeeId = Convert.ToInt32(result["EmpId"]);

            obj.BankName = Convert.ToString(result["BankName"]);
            obj.BankBranch = Convert.ToString(result["BankBranch"]);
            obj.AccountNo = Convert.ToString(result["AccountNo"]);
            obj.AccountName = Convert.ToString(result["AccountName"]);
            //obj.BasicSalary = Convert.ToInt32(result["BasicSalary"]);
            obj.PaySchedule = Convert.ToString(result["PaySchedule"]);

            obj.BasicSalary = Convert.ToString(result["Salary"]);
            obj.OTRate = Convert.ToString(result["OTRate"]);
            obj.WorkingHR = Convert.ToDecimal(result["WorkingHR"]);

            return obj;
        }

        public Promotion GetJobDetailsById(string EmpId)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "getJobHistoryById" }
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = EmpId}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spEmployee", param);
            Promotion obj = new Promotion();
            obj.EmployeeId = Convert.ToInt32(result["EmpId"]);
            obj.DepartmentId = Convert.ToInt32(result["DepartmentId"]);
            obj.DesignationId = Convert.ToInt32(result["DesignationId"]);
            obj.StartDate = Convert.ToDateTime(result["StartDate"]);
            obj.EndDate = result["EndDate"] != DBNull.Value ? Convert.ToDateTime(result["EndDate"]) : (DateTime?)null; //Convert.ToDateTime(result["EndDate"]);
            obj.Salary = Convert.ToString(result["Salary"]);

            return obj;
        }

        public DbResult UpdateJob(Promotion obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag }
                                  ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                  ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = obj.EmployeeId}
                                  ,new SqlParameter("@DesignationId", SqlDbType.Int) { Value = obj.DesignationId}
                                  ,new SqlParameter("@DepartmentId", SqlDbType.Int) { Value = obj.DepartmentId}
                                  ,new SqlParameter("@StartDate", SqlDbType.DateTime) { Value = obj.StartDate}
                                  ,new SqlParameter("@BasicSalary", SqlDbType.VarChar,20) { Value = obj.Salary}

                                  ,new SqlParameter("@userId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }
        public DbResult FireEmployee(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="fire-Employee"}
                                     ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }

        public DbResult UploadProfile(int Id, string filePath)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="upload-img"}
                                     ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value =Id }
                                     ,new SqlParameter("@ProfilePath", SqlDbType.VarChar,100) { Value =filePath }
                                    };
            return SqlHelper.ParseDbResult("spEmployee", param);
        }

        public string ImagePathById(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="get-img"}
                                     ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value =Id }
                                    };
            var result = SqlHelper.ExecuteDataTable("spEmployee", param);

            string ouput = result.Rows[0]["ProfilePath"].ToString();
            return ouput;
        }

    }
}
