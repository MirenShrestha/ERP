using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Web;



namespace ERP.Common.Helper
{
   public static class SessionHelper
    {

        public static string GetUserName()
        {

            string userName = HttpContext.Current.User.Identity.GetUserName();
            if (userName == "")
            {
                userName = "guest";
            }
            return userName;
        }

        public static string GetUserID()
        {
            string userID = HttpContext.Current.User.Identity.GetUserId();
            if (userID == "")
            {
                userID = "admin";
            }
            return userID;
        }


        public static bool IsUserSuperAdmin()
        {
            //  bool userRole = HttpContext.Current.User.IsInRole("SuperAdmin");
            return true;
        }

        public static string GetRoleName(string id)
        {


            Role[] arary = {new Role { RoleId = "7498b017-9522-44cb-b26a-6889148b5313", RoleName = "SuperAdmin" },
                                     new Role { RoleId = "73dd461a-8080-4a90-a2ee-0ac47cfe4e6d", RoleName = "Admin" },
                                     new Role { RoleId = "db07d173-33ba-4a80-9212-c4240b0527da", RoleName = "IT Manager" },
                                     new Role { RoleId = "d0531153-d845-46c2-86d4-d9e1c35fc93a", RoleName = "Developer" },
                                     new Role { RoleId = "28e1c10e-de7d-4d95-b479-e8687787f92f", RoleName = "Manager" },
                                 };
            int keyIndex = Array.FindIndex(arary, s => s.RoleId == id);
            if (keyIndex == -1)
            {
                return null;
            }
            return arary[keyIndex].RoleName;
        }
      

        public static string GetComputerCode()
        {
            if (HttpContext.Current.Session["ComputerCode"] != null)
            {
               
                return HttpContext.Current.Session["ComputerCode"].ToString();
            }
            else
            {
                return "";
            }
        }
       

        public static Dictionary<string, int> GetApplication()
        {
            Dictionary<string, int> arr = new Dictionary<string, int>();
            arr.Add("AppId", 1);
            arr.Add("ModuleId", 1);
            return arr;
        }
        public static string GetUserSession()
        {
            return GetSession<string>("userName","");
        }

        public static string GetUserFullName()
        {
            return GetSession<string>("userFullName", "");
        }
        public static string GetUserCompanyId()
        {
            return GetSession<string>("companyId", "");
        }
        public static string GetUserEmail()
        {
            return GetSession<string>("userEmail", "");
        }
        public static string GetUserPhone()
        {
            return GetSession<string>("userPhone", "");
        }
        public static string GetUserSessionTimeOut()
        {
            return GetSession<string>("userSessionTimeOut", "");
        }

        public static DateTime? GetUserDOB()
        {
            return GetSession<DateTime?>("userDOB", null);
        }

        public static string GetUserGender()
        {
            return GetSession<string>("userGender", "");
        }

        public static void SetSessionTimeOut(int? time)
        {
            if(time!=null)
              {
                HttpContext.Current.Session.Timeout =Convert.ToInt16(time);
            }
        }

        /// <summary> 
        /// Get value. 
        /// </summary> 
        /// <typeparam name="T"></typeparam> 
        /// <param name="session"></param> 
        /// <param name="key"></param> 
        /// <returns></returns> 
        public static T GetSession<T>(string key,T defaultValue)
        {
            return HttpContext.Current.Session[key] == null ? defaultValue : (T)HttpContext.Current.Session[key];
        }
        /// <summary> 
        /// Set value. 
        /// </summary> 
        /// <typeparam name="T"></typeparam> 
        /// <param name="session"></param> 
        /// <param name="key"></param> 
        /// <param name="value"></param> 
        public static void SetSession<T>(string key, object value)
        {
            HttpContext.Current.Session[key] = value;
        }

        public static void RemoveSession(string key="")
        {
            if (HttpContext.Current.Session[key] == null)
            {
                return;
            }
            HttpContext.Current.Session.Remove(key);
        }

        public static void DestroySession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.Session.RemoveAll();

          
            HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-365));
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();
        }





    }

    class Pagemodule
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    class Role
    {
        public string RoleId { get; set; }
        public string RoleName { get; set; }

    }
}
