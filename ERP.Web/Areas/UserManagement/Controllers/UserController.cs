using ERP.Core.Models.UserManagement;
using ERP.Service.Interfaces.UserManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.UserManagement.Controllers
{
    public class UserController : BaseController
    {
        IUserService iAppService = null;
 
        public UserController(IUserService iApp)
        {
            iAppService = iApp;
        }

        // GET: UserManagement/User
        public ActionResult Index()
        {
            return View();
        }

    }
}