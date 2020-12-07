using ERP.Core.Models.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using ERP.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Web.Areas.TicketingManagement.Controllers
{
    public class StationController : BaseController
    {

        IStationService iStation;
        public StationController(IStationService stationService)
        {
            iStation = stationService;
        }

        // GET: TicketingManagement/Station
        public ActionResult Index()
        {
            return PartialView();
        }

        public ActionResult List()
        {
            IEnumerable<Station> list = iStation.List();
            return PartialView(list);
        }

        public ActionResult Create()
        {
            return PartialView(new Station());
        }

        [HttpPost]
        public ActionResult Create(Station obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iStation.Update(obj, "i");
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
            Station obj = iStation.GetById(id);
            return PartialView(obj);
        }

        [HttpPost]
        public ActionResult Edit(Station obj)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var result = iStation.Update(obj, "u");
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
        public ActionResult Delete(string id)
        {
            try
            {
                var result = iStation.Delete(id);
                return Json(new
                {
                    ErrorCode = result.ErrorCode,
                    Message = result.Msg,
                    Id = result.Id,
                    JsonRequestBehavior.AllowGet
                });
            }
            catch(Exception ex)
            {
                return Json(new { ErrorCode = 1, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


    }
}