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
    public class OrganisationRepository
    {
        public DbResult Update(Organisation obj, string flag)
        {

            SqlParameter[] param ={  new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value =flag=="i"? "i":"u" }
                                    ,new SqlParameter("@user", SqlDbType.NVarChar,128) { Value =SessionHelper.GetUserID() }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = obj.Id }
                                    ,new SqlParameter("@Name", SqlDbType.NVarChar, 128) { Value = obj.Name }
                                    ,new SqlParameter("@Address", SqlDbType.NVarChar, 128) { Value = obj.Address }
                                    ,new SqlParameter("@ContactNo", SqlDbType.NVarChar, 128) { Value = obj.ContactNo }
                                    ,new SqlParameter("@VatNo", SqlDbType.NVarChar, 128) { Value = obj.VatPan }

                                  };
            return SqlHelper.ParseDbResult("spCompanyInfo", param);
        }

        public Organisation GetById(string Id)
        {
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = "s" }
                                    ,new SqlParameter("@id", SqlDbType.NVarChar, 128) { Value = Id}
                                   };
            DataRow result = SqlHelper.ExecuteDataRow("spCompanyInfo", param);
            Organisation obj = new Organisation();
            obj.Id = Convert.ToInt32(result["Id"]);
            obj.Name = result["Name"].ToString();
            obj.Address = result["Address"].ToString();
            obj.ContactNo = Convert.ToInt32(result["ContactNo"]);
            obj.VatPan = result["VatNo"].ToString();

            return obj;
        }
        public DbResult Delete(string Id)
        {
            SqlParameter[] param =  { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value ="d"}
                                     ,new SqlParameter("@id", SqlDbType.NVarChar,128) { Value =Id }
                                    };
            return SqlHelper.ParseDbResult("spCompanyInfo", param);
        }

        public List<Organisation> List(bool Active = false)
        {
            List<Organisation> lst = new List<Organisation>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 50) { Value = Active == false ? "a" : "la" }                                    
                                  };

            DataTable result = SqlHelper.ExecuteDataTable("spCompanyInfo", param);


            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    Organisation obj = new Organisation();
                    obj.Id = Convert.ToInt32(drow["Id"]);
                    obj.Name = drow["Name"].ToString();
                    obj.Address = drow["Address"].ToString();
                    obj.ContactNo = Convert.ToInt32(drow["ContactNo"]);
                    obj.VatPan = drow["VatNo"].ToString();
                    lst.Add(obj);

                }
            }
            return lst;
        }
    }
}
