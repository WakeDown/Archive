using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ArchiveWeb.Models;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Controllers
{
    public class RequestController : BaseController
    {
        // GET: Request
        public ActionResult Index(int? idReq, string auth, string reqDate)
        {
            if (!CurUser.HasAccess(AdGroup.ArchivePlacesEditor, AdGroup.ArchiveCreateRequest)) return HttpNotFound();
            int totalCount;
            var list = DocRequest.GetList(out totalCount, idReq, auth, reqDate);

                return View(list);
        }
        [HttpPost]
        public JsonResult CreateRequest(int[] ids)
        {
            int id = DocRequest.Create(CurUser.Sid, ids);
            return Json(new {id=id });
        }

        [HttpPost]
        public JsonResult GetDocumentList(int idRequest)
        {
            var list = DocRequest.GetDocumentList(idRequest);
            return Json(list);
        }

        [HttpPost]
        public JsonResult SetRequestWork(int id)
        {
            DocRequest.SetWork(CurUser.Sid, id);
            return Json(new { });
        }

        [HttpPost]
        public JsonResult SetRequestGiven(int id)
        {
            DocRequest.SetGiven(CurUser.Sid, id);
            return Json(new { });
        }

        [HttpPost]
        public JsonResult SetDocumentCame(int idDoc, int idReq)
        {
            DocRequest.SetDocumentCame(idDoc, idReq, CurUser.Sid);
            
            return Json(new { });
        }
    }
}