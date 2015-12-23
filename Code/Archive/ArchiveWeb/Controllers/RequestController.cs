using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ArchiveWeb.Models;
using ArchiveWeb.Objects;
using SelectPdf;

namespace ArchiveWeb.Controllers
{
    public class RequestController : BaseController
    {
        // GET: Request
        public ActionResult Index(int? idReq, string auth, string reqDate, string doc)
        {
            if (!CurUser.HasAccess(AdGroup.ArchivePlacesEditor, AdGroup.ArchiveCreateRequest)) return HttpNotFound();
            int totalCount;
            var list = DocRequest.GetList(out totalCount, idReq, auth, reqDate,true, doc);

                return View(list);
        }
        [HttpPost]
        public JsonResult CreateRequest(int[] ids)
        {
            int id = DocRequest.Create(CurUser, CurUser.Sid, ids);
            return Json(new {id=id });
        }

        [HttpPost]
        public JsonResult GetDocumentList(int idRequest)
        {
            int totalCount;
            var list = Document.GetList(CurUser, out totalCount, idRequest:idRequest);
            return Json(list);
        }

        [HttpPost]
        public JsonResult SetRequestWork(int id)
        {
            DocRequest.SetWork(CurUser, CurUser.Sid, id);
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
          bool reqDone = DocRequest.SetDocumentCame(idDoc, idReq, CurUser.Sid);
            
            return Json(new { reqDone });
        }

        public ActionResult AktPdf(int? id)
        {
            HtmlToPdf converter = new HtmlToPdf();

            string url = Url.Action("Akt", new { id });
            var leftPartUrl = String.Format("{0}://{1}:{2}", Request.RequestContext.HttpContext.Request.Url.Scheme, Request.RequestContext.HttpContext.Request.Url.Host, Request.RequestContext.HttpContext.Request.Url.Port);
            url = String.Format("{1}{0}", url, leftPartUrl);
            PdfDocument doc = converter.ConvertUrl(url);
            MemoryStream stream = new MemoryStream();
            doc.Save(stream);
            return File(stream.ToArray(), "application/pdf");
        }
        
        public ActionResult Akt(int? id)
        {
            if (!id.HasValue) return HttpNotFound();
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return HttpNotFound();
            var req = new DocRequest(id.Value);
            return View(req);
        }
    }
}