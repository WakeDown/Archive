using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ArchiveWeb.Models;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            //ViewBag.CurUser = GetCurUser();
            //ViewBag.DocumentList = new List<Document>() { new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" }, new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" } }; 
            var lst = Document.GetList();
            return View(lst);
        }

        public ActionResult Request()
        {

            return View();
        }
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(Document model)
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");

            //Save employee
            try
            {
                model.CurUserAdSid = CurUser.Sid;
                int id = model.Add();
                //if (!complete) throw new Exception(responseMessage.ErrorMessage);
                //return RedirectToAction("Edit", "Document", new { id = id });
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return View("Add", model);
            }

        }
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (!id.HasValue) return RedirectToAction("Add");
            var doc = new Document(id.Value);
            return View(doc);
        }
        [HttpPost]
        public JsonResult GetContractorList(string name)
        {
            var list = Contractor.GetSelectionList(name);
            return Json(list);
        }
    }
}