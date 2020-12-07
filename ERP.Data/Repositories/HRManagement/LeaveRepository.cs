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
    public class LeaveRepository
    {
        public DbResult Update(LeaveApplication obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = obj.Id }
                                    ,new SqlParameter("@DepartmentId", SqlDbType.Int) { Value = obj.DepartmentId}
                                    ,new SqlParameter("@EmployeeId", SqlDbType.Int) { Value = obj.EmpId}

                                    ,new SqlParameter("@Reason", SqlDbType.VarChar,50) { Value = obj.Reason}
                                    ,new SqlParameter("@Type", SqlDbType.VarChar,50) { Value = obj.LeaveType}
                                    ,new SqlParameter("@FromDate", SqlDbType.DateTime) { Value = obj.StartDate}
                                    ,new SqlParameter("@ToDate", SqlDbType.DateTime) { Value = obj.EndDate}
                                    ,new SqlParameter("@Remarks", SqlDbType.VarChar,300) { Value = obj.Remarks}
                                    ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }

                                  };
            return SqlHelper.ParseDbResult("spLeaveApplications", param);
        }

        public LeaveApplication GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spLeaveApplications", param);
            LeaveApplication obj = new LeaveApplication();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.DepartmentId = Convert.ToInt32(result["DepartmentId"]);
            obj.EmpId = Convert.ToInt32(result["EmployeeId"]);
            obj.Reason = result["Reason"].ToString();
            obj.LeaveType = result["Type"].ToString();
            obj.StartDate = Convert.ToDateTime(result["FromDate"]);
            obj.EndDate = Convert.ToDateTime(result["ToDate"]);
            obj.Remarks = result["Remarks"].ToString();
            obj.Status = result["Status"].ToString();

            return obj;
        }

        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                         ,new SqlParameter("@id", SqlDbType.Int) { Value =Id }
                                        };
            return SqlHelper.ParseDbResult("spLeaveApplications", param);
        }

        public DbResult LeaveAction(string Id, string type)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="action"}
                                         ,new SqlParameter("@id", SqlDbType.Int) { Value =Id }
                                         ,new SqlParameter("@Status", SqlDbType.VarChar,40) { Value =type }
                                         ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }

                                        };
            return SqlHelper.ParseDbResult("spLeaveApplications", param);
        }

        public List<LeaveApplicationVM> AllList()
        {
            List<LeaveApplicationVM> lst = new List<LeaveApplicationVM>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "a"  }
                                     ,new SqlParameter("@UserId", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }};
            DataTable result = SqlHelper.ExecuteDataTable("spLeaveApplications", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    LeaveApplicationVM obj = new LeaveApplicationVM();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Department = drow["Department"].ToString();
                    obj.EmployeeName = Convert.ToString(drow["Name"]);

                    obj.Reason = Convert.ToString(drow["Reason"]);
                    obj.LeaveType = Convert.ToString(drow["Type"]);
                    obj.StartDate = Convert.ToDateTime(drow["FromDate"]);
                    obj.EndDate = Convert.ToDateTime(drow["ToDate"]);
                    obj.Remarks = Convert.ToString(drow["Remarks"]);
                    obj.Status = Convert.ToString(drow["Status"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }




    }
}
