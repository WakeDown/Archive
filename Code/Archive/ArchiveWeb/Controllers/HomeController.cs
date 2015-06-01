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
            ViewBag.CurUser = GetCurUser();
            ViewBag.DocumentList = new List<Document>() { new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" }, new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" } }; 

            return View();
        }

        public ActionResult Request()
        {
            ViewBag.CurUser = GetCurUser();

            return View();
        }
    }
}