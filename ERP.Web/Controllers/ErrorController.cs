using ERP.Core.Models.Common;
using ERP.Service.Interfaces;
using ERP.Service.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace ERP.Web.Controllers
{
    public class ErrorController : BaseController
    {
        ICommonLibraryService iCommonLibrary;
        public ErrorController(ICommonLibraryService commonLibraryService)
        {
            iCommonLibrary = commonLibraryService;
        }
        public ActionResult Index()
        {
            return PartialView("Index");
        }

       //Error List view
       public ActionResult ReportView(string Code, string FromDate, string ToDate)
       {

            //List<ApplicationLog> lst = iError.GetByParameters(Code, FromDate, ToDate);
            List<ApplicationLog> lst = iCommonLibrary.GetByParameters(Code, FromDate, ToDate);
            return PartialView(lst);
       }

        public ActionResult Error()
        {
            string errorMessage = string.Empty;
            string code = Convert.ToString(HttpContext.Application["code"]);
            if (!string.IsNullOrEmpty(code))
            {
                var errorCodes = code.Split('|');
                string httpErrorCode = Convert.ToString(errorCodes[1]);
               
                switch(httpErrorCode)
                {
                    case "400":
                        errorMessage = "<span><b>Bad Request : </b>The server cannot process the request due to something that is perceived to be a client error.</span>";
                        break;
                    case "401":
                        errorMessage = "<span><b>Unauthorized : </b>The requested resource requires an authentication.</span>";
                        break;
                    case "403":
                        errorMessage = "<span><b>Access Denied : </b>The requested resource requires an authentication.</span>";
                        break;
                    case "404":
                        errorMessage = "<span><b>Page Not Found : </b>The requested resource could not be found but may be available again in the future.</span>";
                        break;
                    case "500":
                    case "501":
                    case "502":
                    case "503":
                    case "520":
                        errorMessage = "<span><b>Internal Server Error : </b>An unexpected condition was encountered.</span>";
                        break;
                    case "521":
                        errorMessage = "<span><b>Origin Error - Unknown Host : </b>The requested hostname is not routed. Use only hostnames to access resources.</span>";
                        break;
                   

                    default:
                        errorMessage = "<span>Please contact to administration.</span>";
                        break;
                }
                ViewBag.ErrorCode = Convert.ToString(errorCodes[0]);
                ViewBag.Message = errorMessage;
            }
            return View();
        }
    }
}