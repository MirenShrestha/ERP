using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using ERP.Web.Models;
using ERP.Service.Interfaces.UserManagement;
using System.Collections.Generic;
using ERP.Core.Models.UserManagement;
using ERP.Common.Helper;
using ERP.Service.Services;
using System.Web.Configuration;
using System.Web.Security;
using ERP.Service.Interfaces.GeneralManagement;
using System.Security.Claims;
using Microsoft.AspNet.Identity.EntityFramework;
using ERP.Service.Interfaces;
using ERP.Service.Interfaces.HRManagement;

namespace ERP.Web.Controllers
{
    [Authorize]
    [NoCache]

    public class AccountController : Controller //: BaseController
    {
        IDropDownService iDropDownService = null;

        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        IUserService iAppService = null;
        ICommonLibraryService iCommonLibrary = null;
        IEmployeeService iEmployee = null;
        public AccountController(IUserService iApps, IDropDownService iDropDownServ, ICommonLibraryService commonLibraryService, IEmployeeService employee)
        {
            iAppService = iApps;
            iDropDownService = iDropDownServ;
            iCommonLibrary = commonLibraryService;
            iEmployee = employee;
        }

        public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;

        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set
            {
                _signInManager = value;
            }
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            try
            {
                var lsts = iAppService.List();

                IEnumerable<User> lst = iAppService.List();
                return PartialView(lst);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            LoginViewModel common = new LoginViewModel();
            HttpCookie cookie = Request.Cookies["_userVerifiction"];
            if(cookie != null)
            {
                string getUsername = cookie["dataname"].ToString();
                byte[] decryptUsername = Convert.FromBase64String(getUsername);
                string decryptedUsername = System.Text.ASCIIEncoding.ASCII.GetString(decryptUsername);
                ViewBag.username = decryptedUsername;
                common.RememberMe = true;
            }
            if (HttpContext.Session["userName"] != null)
                return RedirectToAction("Index", "Home");
            ViewBag.ReturnUrl = returnUrl;
            ViewBag.ModuleName = WebConfigurationManager.AppSettings["Login"];
            //ViewBag.ModuleName = CommonLibraryService.GetKeyTitle("Login").Title;
            //return PartialView();// View();
            LoginViewModel obj = new LoginViewModel();
            return View(obj);
        }

        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return PartialView(model);// View(model);
            }
            HttpCookie cookie = new HttpCookie("_userVerifiction");
            if(model.RememberMe == true)
            {
                byte[] userName = System.Text.ASCIIEncoding.ASCII.GetBytes(model.UserName);
                string encryptUserName = Convert.ToBase64String(userName);
                cookie["dataname"] = encryptUserName;
                cookie.Expires = DateTime.Now.AddDays(7);
                HttpContext.Response.Cookies.Add(cookie);
            }
            else
            {
                cookie.Expires = DateTime.Now.AddDays(-1);
                HttpContext.Response.Cookies.Add(cookie);
            }
            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            var result = await SignInManager.PasswordSignInAsync(model.UserName, model.Password, model.RememberMe, shouldLockout: false);
            ViewBag.result = result;
            switch (result)
            {
                case SignInStatus.Success:
                    return RedirectToAction("Dashboard", "Account", new { returnUrl = returnUrl });
                case SignInStatus.LockedOut:
                    return View("Lockout");
                case SignInStatus.RequiresVerification:
                    return RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = model.RememberMe });
                case SignInStatus.Failure:
                default:
                    ModelState.AddModelError("", "Invalid login attempt.");
                    return View(model);
            }
        }

        public ActionResult Dashboard(string returnUrl)
        {
            if (User.IsInRole("Super Admin") || User.IsInRole("Admin"))
            {
                SetUserSession();
                if (Url.IsLocalUrl(returnUrl))
                {
                    ViewBag.ReturnUrl = returnUrl;
                    return RedirectPermanent(returnUrl);
                    // return Redirect(returnUrl);

                }
                else
                {
                    return RedirectToAction("Index", "Home");
                    //return RedirectToAction("Index", "Report" , new { area = "StockInventoryManagement"});
                }
            }
            else
            {
                return RedirectToAction("LogOff", "Account"); 
            }
            //var UserId = User.Identity.GetUserId();
            //var role = UserManager.GetRoles(UserId);
            //string roleName = role[0];

          
            //return RedirectPermanent(returnUrl);
        }
        public void SetUserSession()
        {
            ViewModelUserInformation userInformation = iCommonLibrary.GetUserInformation();
            SessionHelper.SetSession<string>("userName", User.Identity.Name);
            SessionHelper.SetSession<string>("userFullName", userInformation.FullName);
            SessionHelper.SetSession<string>("companyId", userInformation.CompanyId);
            SessionHelper.SetSession<string>("userEmail", userInformation.Email);
            SessionHelper.SetSession<string>("userPhone", userInformation.Phone);
            SessionHelper.SetSession<int?>("userSessionTimeOut", userInformation.SessionTimeOut);
            SessionHelper.SetSession<DateTime?>("userDOB", userInformation.DOB);
            SessionHelper.SetSession<string>("userGender", userInformation.Gender);
            SessionHelper.SetSession<string>("fiscalCode", userInformation.FiscalCode);

            SessionHelper.SetSessionTimeOut(userInformation.SessionTimeOut);
            // SessionHelper.SetSession<string>("userKey", CommonLibraryService.GetKeyName(1).Key);

            //var UserId = User.Identity.GetUserId();
            //var role = UserManager.GetRoles(UserId);
            //string roleName = role[0];
        }

     
        // GET: /Account/Register
        [AllowAnonymous]
        public PartialViewResult Register()
        {
            //ViewBag.District = new SelectList(iDropDownService.GetDropDowns("district"), "Id", "DisplayName");

            ViewBag.Roles = new SelectList(iDropDownService.GetDropDowns("roles"), "Id", "DisplayName");
            ViewBag.Employee = new SelectList(iDropDownService.GetDropDowns("employee"), "Id", "DisplayName");

            return PartialView(new Register());
        }
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(Register model)
        {
            try
            {
                if (ModelState.IsValid)
                {

                    var empInfo = iEmployee.GetPersonalById(Convert.ToString(model.EmployeeId));
                    

                    var user = new ApplicationUser { UserName = model.UserName, Email = model.Email, PhoneNumber = empInfo.Phone };
                    var result = await UserManager.CreateAsync(user, model.Password);
                    if (result.Succeeded)
                    {
                        model.Id = user.Id;

                        User obj = new Core.Models.UserManagement.User()
                        {
                            Id = user.Id,
                            Phone = empInfo.Phone,
                            Mobile = empInfo.Phone,
                            FirstName = empInfo.FirstName,
                            MiddleName = empInfo.MiddleName,
                            LastName = empInfo.LastName,
                            Gender = empInfo.Gender,
                            DOB = empInfo.DOB,
                            State = empInfo.StateId,
                            District = empInfo.DistrictId,
                            Address = empInfo.Address,
                            UserName = model.UserName,
                            Email = model.Email,
                            Password = model.Password,
                            RoleId = model.RoleId,
                            EmployeeId = model.EmployeeId
                        };

                        var res = iAppService.Update(obj, "i");
                        return Json(new
                        {
                            ErrorCode = res.ErrorCode,
                            Message = res.Msg,
                            Id = res.Id,
                            JsonRequestBehavior.AllowGet
                        });

                        // await SignInManager.SignInAsync(user, isPersistent:false, rememberBrowser:false);

                        // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                        // Send an email with this link
                        // string code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                        // var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                        // await UserManager.SendEmailAsync(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>");

                        //  return RedirectToAction("Index", "Home");
                    }
                    //  AddErrors(result);
                    else
                    {
                        var err = result.Errors.ToArray();
                        return Json(new
                        {
                            ErrorCode = "1",
                            Message = Convert.ToString(err[0]),
                            Id = "",
                            JsonRequestBehavior.AllowGet
                        });
                    }
                }
                else
                {
                    var error = ModelState.Select(x => x.Value.Errors).FirstOrDefault().Select(x => x.ErrorMessage);
                    return Json(new
                    {
                        ErrorCode = "1",
                        Message = error,
                        Id = "",
                        JsonRequestBehavior.AllowGet
                    });
                }

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    ErrorCode = 1,
                    Message = ex.Message,
                    Id = "",
                    JsonRequestBehavior.AllowGet
                });
            }
        }


        public ActionResult Edit(string id)
        {
            User obj = iAppService.GetById(id);

            Register reg = new Register()
            {
                Id = obj.Id,
                EmployeeId =obj.EmployeeId,
                UserName = obj.UserName,
                RoleId  = obj.RoleId,
                Email   = obj.Email
            };

            ViewBag.Employee = new SelectList(iDropDownService.GetDropDowns("employee"), "Id", "DisplayName");
            ViewBag.Roles = new SelectList(iDropDownService.GetDropDowns("roles"), "Id", "DisplayName");

            return PartialView(reg);
        }


        [HttpPost]
        public ActionResult Edit(Register obj)
        {
            try
            {
                var result = iAppService.UpdateUser(obj);
                return Json(new
                {
                    ErrorCode = result.ErrorCode,
                    Message = result.Msg,
                    Id = result.Id,
                    JsonRequestBehavior.AllowGet
                });
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                var result = iAppService.Delete(id);
                return Json(new
                {
                    ErrorCode = result.ErrorCode,
                    Message = result.Msg,
                    Id = result.Id,
                    JsonRequestBehavior.AllowGet
                });
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult ChangePassword(string id)
        {
            ChangePasswordViewModel obj = new ChangePasswordViewModel()
            {
                UserId = id
            };
            return PartialView(obj);
        }

        // POST: /Manage/ChangePassword
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ChangePassword(ChangePasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            //var result = await UserManager.ChangePasswordAsync(User.Identity.GetUserId(), model.OldPassword, model.NewPassword);
            var result = await UserManager.ChangePasswordAsync(model.UserId, model.OldPassword, model.NewPassword);

            if (result.Succeeded)
            {
                return Json(new { ErrorCode = "0", Message = "Password has been changed." }, JsonRequestBehavior.AllowGet);
            }
            AddErrors(result);
            //return View(model);

            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LogOff(User o)
        {
            return View();
        }

        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            FormsAuthentication.SignOut();
            SessionHelper.DestroySession();
            return RedirectToAction("Login", "Account");
        }



        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_userManager != null)
                {
                    _userManager.Dispose();
                    _userManager = null;
                }

                if (_signInManager != null)
                {
                    _signInManager.Dispose();
                    _signInManager = null;
                }
            }

            base.Dispose(disposing);
        }

        #region Helpers
        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        internal class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri)
                : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }
        #endregion
    }
}