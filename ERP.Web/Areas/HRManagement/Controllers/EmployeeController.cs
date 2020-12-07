using ERP.Core.Models.HRManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Service.Interfaces.HRManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Windows.Forms;

namespace ERP.Web.Areas.HRManagement.Controllers
{
    public class EmployeeController : BaseController
    {
        IDropDownService iDropDownService;
        IEmployeeService iEmployee;
        public EmployeeController(IDropDownService dropDownService, IEmployeeService employeeService)
        {
            iDropDownService = dropDownService;
            iEmployee = employeeService;
        }
        // GET: HRManagement/Employee
        public ActionResult Index()
        {

            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<EmployeeViewModel> list = iEmployee.List();
            return PartialView(list);
        }
        public ActionResult Create()
        {
            return PartialView();
        }

        public ActionResult PersonalDetail()
        {
            ViewBag.District = new SelectList(iDropDownService.GetDropDowns("district"), "Id", "DisplayName");
            ViewBag.Province = new SelectList(iDropDownService.GetDropDowns("Province"), "Id", "DisplayName");

            return PartialView(new EmployeeDetails());
        }

        [HttpPost]
        public ActionResult PersonalDetail(EmployeeDetails obj)
        {
            if (ModelState.IsValid)
            {
                ViewBag.District = new SelectList(iDropDownService.GetDropDowns("district"), "Id", "DisplayName");
                ViewBag.Province = new SelectList(iDropDownService.GetDropDowns("Province"), "Id", "DisplayName");

                try
                {
                    var result = iEmployee.Update(obj, "i");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult UploadProfile(string id, HttpPostedFileBase UploadFile)
        {
            try
            {
                if (UploadFile != null && UploadFile.ContentLength > 0) //size
                {
                    var supportedTypes = new[] {".jpg", ".png",".jpeg",".gif",".bmp",".tif",".tiff"};
                    var name = Path.GetFileName(UploadFile.FileName);
                    var fileName = Path.GetFileNameWithoutExtension(UploadFile.FileName);
                    var fileExtension = Path.GetExtension(name).ToLower();
                    if (!supportedTypes.Contains(fileExtension))
                    {
                        return Json(new
                        {
                            ErrorCode = 1,
                            Message = "Unsupported Format",
                            Id = 0,
                            JsonRequestBehavior.AllowGet
                        });
                    }

                    var newFileName = "p_" + DateTime.Now.ToString("ddmmyyyy") + "_" + id + fileName ;
                    string folder = ConfigurationManager.AppSettings["HrFile"];
                    var filePath = Path.Combine(Server.MapPath(folder), newFileName + fileExtension);

                    UploadFile.SaveAs(filePath);
                    ModelState.Clear();


                    var result = iEmployee.UploadProfile(Convert.ToInt32(id), newFileName + fileExtension);
                    return Json(new
                    {
                        ErrorCode = result.ErrorCode,
                        Message = result.Msg,
                        Id = result.Id,
                        JsonRequestBehavior.AllowGet
                    });
                }
            }
            catch (Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult EmploymentDetails()
        {
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");
            ViewBag.Shift = new SelectList(iDropDownService.GetDropDowns("shift"), "Id", "DisplayName");
            ViewBag.EmploymentTypes = new SelectList(iDropDownService.GetDropDowns("employment-Types"), "Id", "DisplayName");

            return PartialView(new EmploymentDetails());
        }

        [HttpPost]
        public ActionResult EmploymentDetails(EmploymentDetails obj, int empId, HttpPostedFileBase UploadFile)
        {
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");
            ViewBag.Shift = new SelectList(iDropDownService.GetDropDowns("shift"), "Id", "DisplayName");
            ViewBag.EmploymentTypes = new SelectList(iDropDownService.GetDropDowns("employment-Types"), "Id", "DisplayName");

            if (ModelState.IsValid)
            {
                try
                {
                    if (UploadFile != null && UploadFile.ContentLength > 0) //size
                    {
                        var supportedTypes = new[] { ".txt", ".doc", ".docx", ".pdf", ".xls", ".xlsx" };

                        var name = Path.GetFileName(UploadFile.FileName);
                        var fileName = Path.GetFileNameWithoutExtension(UploadFile.FileName);
                        var fileExtension = Path.GetExtension(name);
                        if (!supportedTypes.Contains(fileExtension))
                        {
                            return Json(new
                            {
                                ErrorCode = 1,
                                Message = "Unsupported Format",
                                Id = 0,
                                JsonRequestBehavior.AllowGet
                            });
                        }

                        //5 MB = 5242880 Bytes(in binary)
                        if (UploadFile.ContentLength > 5242880)
                        {
                            return Json(new
                            {
                                ErrorCode = 1,
                                Message = "File size must be below 5MB",
                                Id = 0,
                                JsonRequestBehavior.AllowGet
                            });
                        }

                        var newFileName = "c_" + DateTime.Now.ToString("ddmmyyyy") + "_" + obj.EmployeeId + fileName;
                        obj.ContractFile = newFileName;
                        string folder = ConfigurationManager.AppSettings["HrFile"];
                        var filePath = Path.Combine(Server.MapPath(folder), newFileName + fileExtension);

                        UploadFile.SaveAs(filePath);
                        ModelState.Clear();
                    }

                    obj.EmployeeId = empId;
                    var result = iEmployee.UpdateEmployment(obj, "i-employment");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PayDetails()
        {
            return PartialView(new PayDetails());
        }

        [HttpPost]
        public ActionResult PayDetails(PayDetails obj, int empId)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    obj.EmployeeId = empId;
                    var result = iEmployee.UpdatePayDetails(obj, "i-pay");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Edit(string id)
        {
            ViewBag.EmpId = id;
            ViewBag.ImagePath = iEmployee.ImagePathById(id);
            return PartialView();
        }

        public ActionResult PersonalDetailEdit(string empId)
        {

            ViewBag.District = new SelectList(iDropDownService.GetDropDowns("district"), "Id", "DisplayName");
            ViewBag.Province = new SelectList(iDropDownService.GetDropDowns("Province"), "Id", "DisplayName");

            EmployeeDetails obj = iEmployee.GetPersonalById(empId);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult PersonalDetailEdit(EmployeeDetails obj)
        {
            ViewBag.District = new SelectList(iDropDownService.GetDropDowns("district"), "Id", "DisplayName");
            ViewBag.Province = new SelectList(iDropDownService.GetDropDowns("Province"), "Id", "DisplayName");

            if (ModelState.IsValid)
            {
                try
                {
                    var result = iEmployee.Update(obj, "u");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult EmploymentDetailsEdit(string empId)
        {
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");
            ViewBag.Shift = new SelectList(iDropDownService.GetDropDowns("shift"), "Id", "DisplayName");
            ViewBag.EmploymentTypes = new SelectList(iDropDownService.GetDropDowns("employment-Types"), "Id", "DisplayName");

            EmploymentDetails obj = iEmployee.GetJobById(empId);
            return PartialView(obj);
        }


        [HttpPost]
        public ActionResult EmploymentDetailsEdit(EmploymentDetails obj, HttpPostedFileBase UploadFile)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
                    ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");
                    ViewBag.Shift = new SelectList(iDropDownService.GetDropDowns("shift"), "Id", "DisplayName");
                    ViewBag.EmploymentTypes = new SelectList(iDropDownService.GetDropDowns("employment-Types"), "Id", "DisplayName");

                    if (UploadFile != null && UploadFile.ContentLength > 0) //size
                    {
                        var supportedTypes = new[] { ".txt", ".doc", ".docx", ".pdf", ".xls", ".xlsx" };

                        var name = Path.GetFileName(UploadFile.FileName);
                        var fileName = Path.GetFileNameWithoutExtension(UploadFile.FileName);
                        var fileExtension = Path.GetExtension(name);
                        if (!supportedTypes.Contains(fileExtension))
                        {
                            return Json(new
                            {
                                ErrorCode = 1,
                                Message = "Unsupported Format",
                                Id = 0,
                                JsonRequestBehavior.AllowGet
                            });
                        }

                        //5 MB = 5242880 Bytes(in binary)
                        if (UploadFile.ContentLength > 5242880)
                        {
                            return Json(new
                            {
                                ErrorCode = 1,
                                Message = "File size must be below 5MB",
                                Id = 0,
                                JsonRequestBehavior.AllowGet
                            });
                        }

                        var newFileName = "_" + DateTime.Now.ToString("ddmmyyyy") + "_" + obj.EmployeeId + fileName;
                        obj.ContractFile = newFileName;
                        string folder = ConfigurationManager.AppSettings["HrFile"];
                        var filePath = Path.Combine(Server.MapPath(folder), newFileName + fileExtension);

                        UploadFile.SaveAs(filePath);
                        ModelState.Clear();
                    }


                    var result = iEmployee.UpdateEmployment(obj, "u-employment");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);

                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PayDetailsEdit(string empId)
        {
            PayDetails obj = iEmployee.GetPayDetailById(empId);
            return PartialView(obj);
        }


        [HttpPost]
        public ActionResult PayDetailsEdit(PayDetails obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iEmployee.UpdatePayDetails(obj, "u-pay");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Details(string id)
        {
            EmployeeDetailsVM obj = iEmployee.EmployeeDetails(id);
            ViewBag.Path = ConfigurationManager.AppSettings["HrFile"];

            return PartialView(obj);
        }

        #region Promotion

        public ActionResult NewJob(string id)
        {
            ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
            ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");

            Promotion obj = iEmployee.GetJobDetailsById(id);

            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult NewJob(Promotion obj)
        {
            if (ModelState.IsValid)
            {
                ViewBag.Department = new SelectList(iDropDownService.GetDropDowns("department"), "Id", "DisplayName");
                ViewBag.Designation = new SelectList(iDropDownService.GetDropDowns("designation"), "Id", "DisplayName");
                try
                {
                    var result = iEmployee.UpdateJob(obj, "i-newJob");
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
                    return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            Response.TrySkipIisCustomErrors = true;
            string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
            return Json(new { ErrorCode = 1, Message = messages }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Suspend_Fire

        [HttpPost]
        public ActionResult FireEmployee(string id)
        {
            try
            {
                var result = iEmployee.FireEmployee(id);
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
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion



    }
}