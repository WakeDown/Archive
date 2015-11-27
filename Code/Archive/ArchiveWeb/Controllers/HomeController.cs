using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ArchiveWeb.Models;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index(int? topRows, int? page, string docNum, string docDate, string docType, string dateCreate, string state, string place, string idDoc, string contractor)
        {
            //ViewBag.CurUser = GetCurUser();
            //ViewBag.DocumentList = new List<Document>() { new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" }, new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" } }; 
            int totalCount;
            var lst = Document.GetList(out totalCount, topRows, page, docNum, docDate, docType, dateCreate, state, place, idDoc, contractor);
            ViewBag.TotalCount = totalCount;
            ViewBag.PlaceView = CurUser.HasAccess(AdGroup.ArchiveAddDoc);
            return View(lst);
        }

        public ActionResult RequestDoc()
        {

            return View();
        }
        [HttpGet]
        public ActionResult Add()
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");
            return View();
        }
        [HttpPost]
        public ActionResult Add(Document model)
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");

            //Save employee
            try
            {
                if (Request.Files.Count > 0 && Request.Files[0] != null && Request.Files[0].ContentLength > 0)
                {
                    var file = Request.Files[0];

                    string ext = Path.GetExtension(file.FileName).ToLower();

                    if (ext != ".pdf") throw new Exception("Формат файла должен быть PDF");

                    byte[] fileData = null;
                    using (var br = new BinaryReader(file.InputStream))
                    {
                        fileData = br.ReadBytes(file.ContentLength);
                    }
                    model.FileData = fileData;
                    model.FileName = file.FileName;
                }
                int id = model.Add(CurUser.Sid);
                //if (!complete) throw new Exception(responseMessage.ErrorMessage);
                //return RedirectToAction("Edit", "Document", new { id = id });
                if (!String.IsNullOrEmpty(Request.Form["CreateAndClose"]))
                {
                    return RedirectToAction("Index");
                    //return View("WindowClose");
                }
                else if (!String.IsNullOrEmpty(Request.Form["CreateAndContinue"]))
                {
                    return RedirectToAction("Edit", new {id = id});
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return View("Add", model);
            }
        }
        [HttpGet]
        public ActionResult Card(int? id)
        {
            if (!id.HasValue) return RedirectToAction("Add");
            ViewBag.PlaceView = CurUser.HasAccess(AdGroup.ArchiveAddDoc);
            var doc = new Document(id.Value);
            return View(doc);
        }
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");
            if (!id.HasValue) return RedirectToAction("Add");
            var doc = new Document(id.Value);
            return View(doc);
        }
        [HttpPost]
        public ActionResult Edit(Document model)
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");

            //Save employee
            try
            {
                if (Request.Files.Count > 0 && Request.Files[0] != null && Request.Files[0].ContentLength > 0)
                {
                    var file = Request.Files[0];

                    string ext = Path.GetExtension(file.FileName).ToLower();

                    if (ext != ".pdf") throw new Exception("Формат файла должен быть PDF");

                    byte[] fileData = null;
                    using (var br = new BinaryReader(file.InputStream))
                    {
                        fileData = br.ReadBytes(file.ContentLength);
                    }
                    model.FileData = fileData;
                    model.FileName = file.FileName;
                }
                model.Update(CurUser.Sid);

                if (!String.IsNullOrEmpty(Request.Form["CreateAndClose"]))
                {
                    return RedirectToAction("Index");
                    //return View("WindowClose");
                }
                else if (!String.IsNullOrEmpty(Request.Form["CreateAndContinue"]))
                {
                    return RedirectToAction("Card", new { id = model.Id });
                }
                else
                {
                    return RedirectToAction("Index");
                }
                
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return View("Edit", model);
            }
            
        }
        [HttpPost]
        public JsonResult GetContractorList(string name)
        {
            var list = Contractor.GetSelectionList(name);
            return Json(list);
        }
        [HttpPost]
        public JsonResult SetArchiveState(int id, string stack = null, string shelf = null, string folder = null)
        {
            if (stack != null || shelf != null || folder != null)
            {
                var doc = new Document() {Id = id, Stack = stack, Shelf = shelf, Folder = folder};
                doc.Update(CurUser.Sid);
            }

            //if (!id.HasValue) return Json(new {});
            Document.SetArchiveState(id, CurUser.Sid);
            return Json(new { });
        }
        [HttpPost]
        public JsonResult SetOutState(int id, string whoGetSid)
        {
            //if (!id.HasValue) return Json(new {});
            Document.SetOutState(id, whoGetSid, CurUser.Sid);
            return Json(new { });
        }
        [HttpGet]
        public PartialViewResult GetDocumentListItem(int? id)
        {
            if (!id.HasValue) return new PartialViewResult();
            ViewBag.PlaceView = CurUser.HasAccess(AdGroup.ArchiveAddDoc);
            var doc = new Document(id.Value);
            return PartialView("DocumentListItem", doc);
        }
        [HttpPost]
        public JsonResult GetOutEmployeesList(string name)
        {
            var list = Employee.GetOutSelectionList(name);
            return Json(list);
        }

        public ActionResult GetDocFileData(string sid)
        {
            var data =  Document.GetFileData(sid);
            if (data != null && data.Length > 0)
            {
                return File(data, "application/pdf");
            }
            else
            {
                return HttpNotFound();
            }
        }
        [HttpPost]
        public JsonResult DeleteFile(string sid)
        {
            Document.DeleteFile(sid, CurUser.Sid);
            return Json(new {});
        }
        [HttpPost]
        public JsonResult GetContractorFullName(int id)
        {
            string name = Contractor.GetFullName(id);
            return Json(name);
        }
        [HttpPost]
        public JsonResult DocumentDelete(int id)
        {
            Document.Delete(id, CurUser.Sid);
            return Json(new {});
        }
    }
}