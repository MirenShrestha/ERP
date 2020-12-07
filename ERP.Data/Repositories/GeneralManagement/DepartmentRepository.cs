using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.GeneralManagement
{
    public class DepartmentRepository
    {
        public DbResult Update(Department obj, string flag)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@Name", SqlDbType.VarChar, 200) { Value = obj.Name }
                                    ,new SqlParameter("@Code", SqlDbType.NVarChar, 10) { Value = obj.Code }
                                  };
            return SqlHelper.ParseDbResult("spDepartment", param);
        }
        public Department GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@Id", SqlDbType.Int) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spDepartment", param);
            Department obj = new Department();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.Code = result["Code"].ToString();

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@Id", SqlDbType.Int) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spDepartment", param);
        }
        public List<Department> List()
        {
            List<Department> lst = new List<Department>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="a"}
                                   };
            DataTable result = SqlHelper.ExecuteDataTable("spDepartment", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Department obj = new Department();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.Code = drow["Code"].ToString();
                   
                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
