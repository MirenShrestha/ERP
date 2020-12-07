using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using ERP.Core.Models.GeneralManagement;
using ERP.Data.SqlHelpers;

namespace ERP.Data.Repositories.GeneralManagement
{
    public class DropDownRepository
    {
        public List<DropDown> GetDropDowns(string flag, string SearchBy = "")
        {
            List<DropDown> lst = new List<DropDown>();
            SqlParameter[] param = { new SqlParameter("@flag", SqlDbType.VarChar, 100) { Value = flag }
                                  , new SqlParameter("@SearchBy",SqlDbType.VarChar,100){ Value=SearchBy}
                                    };
            DataTable result = SqlHelper.ExecuteDataTable("spDropdownlist", param);

            if (result != null && result.Rows.Count > 0)
            {
                foreach (DataRow drow in result.Rows)
                {
                    DropDown obj = new DropDown();

                    obj.Id = Convert.ToString(drow["Id"]);
                    obj.DisplayName = Convert.ToString(drow["DisplayName"]);

                    lst.Add(obj);
                }
            }
            return lst;
        }

    }
}
