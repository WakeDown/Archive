using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ArchiveWeb.Models;
using ArchiveWeb.Objects;
using ClosedXML.Excel;

namespace ArchiveWeb.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index(int? topRows, int? page, string docNum, string docDate, string docType, string dateCreate, string state, string place, string idDoc, string contractor)
        {
            //ViewBag.CurUser = GetCurUser();
            //ViewBag.DocumentList = new List<Document>() { new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" }, new Document() { DocNumber = "123" }, new Document() { DocNumber = "321" } }; 
            int totalCount;
            //bool t2CardView = CurUser.HasAccess(AdGroup.ArchiveT2CardView);
            var lst = Document.GetList(CurUser, out totalCount, topRows, page, docNum, docDate, docType, dateCreate, state, place, idDoc, contractor);
            ViewBag.TotalCount = totalCount;
            ViewBag.PlaceView = CurUser.HasAccess(AdGroup.ArchiveAddDoc);
            ViewBag.RequestCreate = CurUser.HasAccess(AdGroup.ArchiveCreateRequest);
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
                if (!String.IsNullOrEmpty(Request.Form["t2docDate"]))
                {
                    DateTime t2docDate = Convert.ToDateTime(Request.Form["t2docDate"]);
                    model.DocDate = t2docDate;
                }
                int retCode = model.Add(CurUser.Sid);
                //if (!complete) throw new Exception(responseMessage.ErrorMessage);
                //return RedirectToAction("Edit", "Document", new { id = id });
                bool exists = retCode == -999;

                return RedirectToAction("DocumentPlace",new { id = model.Id, exists = exists });

                if (!String.IsNullOrEmpty(Request.Form["CreateAndClose"]))
                {
                    return RedirectToAction("Index");
                    //return View("WindowClose");
                }
                else if (!String.IsNullOrEmpty(Request.Form["CreateAndContinue"]))
                {
                    return RedirectToAction("Edit", new {id = model.Id });
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

        public ActionResult DocumentPlace(int? id, bool? exists)
        {
            if (!id.HasValue) return HttpNotFound();
            bool t2CardView = CurUser.HasAccess(AdGroup.ArchiveT2CardView);
            var doc = new Document(id.Value, t2CardView);
            ViewBag.Exists = exists;
            return View(doc);
        }

        [HttpGet]
        public ActionResult Card(int? id)
        {
            if (!id.HasValue) return RedirectToAction("Add");
            bool t2CardView = CurUser.HasAccess(AdGroup.ArchiveT2CardView);
            ViewBag.PlaceView = CurUser.HasAccess(AdGroup.ArchiveAddDoc);
            var doc = new Document(id.Value, t2CardView);
            if (doc.Id <= 0) return HttpNotFound();
            return View(doc);
        }
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");
            if (!id.HasValue) return RedirectToAction("Add");
            bool t2CardView = CurUser.HasAccess(AdGroup.ArchiveT2CardView);
            var doc = new Document(id.Value, t2CardView);
            if (doc.Id <= 0) return HttpNotFound();
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
            if (!CurUser.HasAccess(AdGroup.ArchiveDeleteFile)) return Json(new {});
            Document.DeleteFile(sid, CurUser.Sid);
            return Json(new {});
        }
        [HttpPost]
        public JsonResult GetContractorFullName(string uid)
        {
            string name = Contractor.GetFullName(uid);
            return Json(name);
        }
        [HttpPost]
        public JsonResult DocumentDelete(int id)
        {
            Document.Delete(id, CurUser.Sid);
            return Json(new {});
        }

        public ActionResult GetDocumentListBackup()
        {
            if (!CurUser.HasAccess(AdGroup.ArchiveAddDoc)) return RedirectToAction("AccessDenied", "Error");

            var list = Document.GetListBackup();
            var data = DocumentList2Excel(list);

            return File(data, "application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", $"Архив документов - резервная копия от {DateTime.Now.ToString("dd-MM-yyyy")}.xlsx");
        }

        public byte[] DocumentList2Excel(IEnumerable<Document> list)
        {
            XLWorkbook wb = new XLWorkbook();
            IXLWorksheet sheet = wb.AddWorksheet("Документы в архиве");
            const int startCol = 1;
            const int startRow = 1;
            int row = startRow;
            int col = startCol;

            //Заголовок
            sheet.Cell(row, col).Value = "ID";
            sheet.Cell(row, ++col).Value = "Контрагент";
            sheet.Cell(row, ++col).Value = "Юр. лицо Юнит";
            sheet.Cell(row, ++col).Value = "Тип документа";
            sheet.Cell(row, ++col).Value = "№ документа";
            sheet.Cell(row, ++col).Value = "Дата документа";
            sheet.Cell(row, ++col).Value = "Листов";
            sheet.Cell(row, ++col).Value = "Стеллаж";
            sheet.Cell(row, ++col).Value = "Полка";
            sheet.Cell(row, ++col).Value = "Папка";
            sheet.Cell(row, ++col).Value = "Дата приема";
            sheet.Cell(row, ++col).Value = "Приял";
            sheet.Cell(row, ++col).Value = "Статус";
            sheet.Cell(row, ++col).Value = "Дата изменения статуса";
            sheet.Cell(row, ++col).Value = "Изменил статус";
            sheet.Cell(row, ++col).Value = "Выдано";
            // />Заголовок
            int lastCol = col;

            var header = sheet.Range(sheet.Cell(row, startCol), sheet.Cell(row, lastCol));
            header.Style.Font.SetBold();

            foreach (Document doc in list)
            {
                row++;
                col = startCol;

                sheet.Cell(row, col).Value = doc.Id;
                sheet.Cell(row, ++col).Value = doc.ContractorName;
                sheet.Cell(row, ++col).Value = doc.Organization;
                sheet.Cell(row, ++col).Value = doc.DocType;
                sheet.Cell(row, ++col).Value = doc.DocNumber;
                sheet.Cell(row, ++col).Value = doc.DocDate;
                sheet.Cell(row, ++col).Value = doc.SheetCount;
                sheet.Cell(row, ++col).Value = doc.Place.StackNumber;
                sheet.Cell(row, ++col).Value = doc.Place.ShelfNumber;
                sheet.Cell(row, ++col).Value = doc.Place.FolderNumber;
                sheet.Cell(row, ++col).Value = doc.DateCreate;
                sheet.Cell(row, ++col).Value = doc.CreatorName;
                sheet.Cell(row, ++col).Value = doc.State;
                sheet.Cell(row, ++col).Value = doc.DateStateChange;
                sheet.Cell(row, ++col).Value = doc.StateChangerName;
                sheet.Cell(row, ++col).Value = doc.WhoGetName;
            }

            var all = sheet.Range(sheet.Cell(startRow, startCol), sheet.Cell(row, lastCol));
            all.Style.Font.SetFontSize(10);
            all.CreateTable();

            all.Style.Border.SetBottomBorder(XLBorderStyleValues.Thin);
            all.Style.Border.SetBottomBorderColor(XLColor.Gray);
            all.Style.Border.SetTopBorder(XLBorderStyleValues.Thin);
            all.Style.Border.SetTopBorderColor(XLColor.Gray);
            all.Style.Border.SetRightBorder(XLBorderStyleValues.Thin);
            all.Style.Border.SetRightBorderColor(XLColor.Gray);
            all.Style.Border.SetLeftBorder(XLBorderStyleValues.Thin);
            all.Style.Border.SetLeftBorderColor(XLColor.Gray);

            var ms = new MemoryStream();
            wb.SaveAs(ms);
            ms.Seek(0, SeekOrigin.Begin);
            return ms.ToArray();
        }
    }
}