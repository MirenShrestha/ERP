using ERP.Common.Helper;
using ERP.Core.Models;
using ERP.Core.Models.UserManagement;
using ERP.Data.SqlHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ERP.Data.Repositories.UserManagement
{
  public  class UserRepository
    {
        public DbResult Update(User obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = obj.Id }
                                    ,new SqlParameter("@userName", SqlDbType.VarChar, 100) { Value = obj.UserName}
                                    ,new SqlParameter("@phone", SqlDbType.VarChar, 100) { Value = obj.Phone}
                                    ,new SqlParameter("@mobile", SqlDbType.VarChar, 100) { Value = obj.Mobile}
                                    ,new SqlParameter("@firstName", SqlDbType.NVarChar, 20) { Value = obj.FirstName}
                                    ,new SqlParameter("@middleName", SqlDbType.NVarChar, 20) { Value = obj.MiddleName}
                                    ,new SqlParameter("@lastName", SqlDbType.NVarChar, 20) { Value = obj.LastName}
                                    ,new SqlParameter("@gender", SqlDbType.NVarChar, 10) { Value = obj.Gender}
                                    ,new SqlParameter("@dob", SqlDbType.Date) { Value = obj.DOB}
                                    ,new SqlParameter("@state", SqlDbType.SmallInt) { Value = obj.State}
                                    ,new SqlParameter("@vdcMunc", SqlDbType.Int, 100) { Value = obj.VdcMunc}
                                    ,new SqlParameter("@district", SqlDbType.SmallInt, 100) { Value = obj.District}
                                    ,new SqlParameter("@city", SqlDbType.NVarChar, 100) { Value = obj.City}
                                    ,new SqlParameter("@address", SqlDbType.NVarChar, 100) { Value = obj.Address}
                                    ,new SqlParameter("@wardNo", SqlDbType.SmallInt) { Value = obj.WardNo}

                                    ,new SqlParameter("@HashPassword", SqlDbType.NVarChar,200) { Value = GlobalHelper.GetHash(obj.Password)}
                                    ,new SqlParameter("@roleIds", SqlDbType.NVarChar,200) { Value = obj.RoleId}
                                    ,new SqlParameter("@employee", SqlDbType.Int) { Value = obj.EmployeeId}


                                  };
            return SqlHelper.ParseDbResult("spUserProfile", param);
        }

        public DbResult UpdateUser(Register obj)
        {
            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "u-user" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = obj.Id }
                                    ,new SqlParameter("@userName", SqlDbType.VarChar, 100) { Value = obj.UserName}
                                    ,new SqlParameter("@email", SqlDbType.VarChar, 100) { Value = obj.Email}

                                    ,new SqlParameter("@roleIds", SqlDbType.NVarChar,200) { Value = obj.RoleId}

                                  };
            return SqlHelper.ParseDbResult("spUserProfile", param);
        }

        public User GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spUserProfile", param);
            User obj = new User();
            obj.Id = Convert.ToString(result["UserId"]);
            obj.UserName = Convert.ToString(result["UserName"]);
            obj.Email = Convert.ToString(result["Email"]);
            obj.FirstName = Convert.ToString(result["FirstName"]);
            obj.MiddleName = Convert.ToString(result["MiddleName"]);
            obj.LastName = Convert.ToString(result["LastName"]);
            obj.Gender = Convert.ToString(result["Gender"]);
            obj.Address = Convert.ToString(result["Address"]);
            obj.Phone = Convert.ToString(result["PhoneNumber"]);
            obj.Mobile = Convert.ToString(result["Mobile"]);
            obj.State = result["State"]!=DBNull.Value?Convert.ToInt32(result["State"]):(int?)null;
            obj.District = result["District"] != DBNull.Value ? Convert.ToInt32(result["District"]) : (int?)null;
            obj.VdcMunc = result["VDCMunc"] != DBNull.Value ? Convert.ToInt32(result["VDCMunc"]) : (int?)null;
            obj.City = Convert.ToString(result["City"]);
            obj.WardNo = result["WardNo"] != DBNull.Value ? Convert.ToInt32(result["WardNo"]) : (int?)null;
            obj.DOB = result["DOB"] != DBNull.Value ? Convert.ToDateTime(result["DOB"]) : (DateTime?)null;
            obj.EmployeeId = Convert.ToInt32(result["EmployeeId"]);
            obj.RoleId = result["RoleId"].ToString();
            return obj;
			  
        }


        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                     ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spUserProfile", param);

        }

        public List<User> List(bool Active = false)
        {
            List<User> lst = new List<User>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID()}
                                  };
            DataTable result = SqlHelper.ExecuteDataTable("spUserProfile", param);
          

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    User obj = new User();
                    obj.Id = Convert.ToString(drow["UserId"]);
                    obj.UserName = Convert.ToString(drow["UserName"]);
                    obj.Email = Convert.ToString(drow["Email"]);
                    obj.FullName = Convert.ToString(drow["Name"]);
                    obj.Gender = Convert.ToString(drow["Gender"]);
                    obj.Address = Convert.ToString(drow["Address"]);
                    obj.Phone = Convert.ToString(drow["PhoneNumber"]);
                    obj.Mobile = Convert.ToString(drow["Mobile"]);
                    obj.DOB = drow["DOB"]!=DBNull.Value? Convert.ToDateTime(drow["DOB"]):(DateTime?)null;
                    lst.Add(obj);
                  
                }
            }
            return lst;
        }

        public List<ViewModelRole> GetRolesByUserId(string id)
        {
            List<ViewModelRole> lst = new List<ViewModelRole>();
            try
            {
                SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="fetch-userroles"}
                                         ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =id }
                                         ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID()}
                                    };
                DataTable result = SqlHelper.ExecuteDataTable("spUserProfile", param);

                if (result != null && result.Rows.Count > 0)
                {
                    foreach (DataRow drow in result.Rows)
                    {
                        ViewModelRole obj = new ViewModelRole();
                        obj.RoleId = Convert.ToString(drow["RoleId"]);
                        obj.RoleName = Convert.ToString(drow["RoleName"]);
                        obj.IsAssigned = drow["UserId"] != DBNull.Value ? true : false;
                        lst.Add(obj);
                    }
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return lst;
        }
    }
}
