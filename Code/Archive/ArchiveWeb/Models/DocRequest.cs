using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Models
{
    public class DocRequest
    {
        public int Id { get; set; }
        public string CraetorSid { get; set; }
        public string CreatorName { get; set; }
        public DateTime DateCreate { get; set; }
        public int DocsCount { get; set; }
        public int StateId { get; set; }
        public DocRequestState State { get; set; }

        public DocRequest()
        {
        }

        public DocRequest(int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_get", pId);
            if (dt.Rows.Count > 0)
            {
                FillSelf(dt.Rows[0]);
            }
        }

        public DocRequest(DataRow row)
        {
            FillSelf(row);
        }

        public void FillSelf(DataRow row)
        {
            Id = Db.DbHelper.GetValueIntOrDefault(row, "id");
            CreatorName = Db.DbHelper.GetValueString(row, "creator_name");
            DateCreate = Db.DbHelper.GetValueDateTimeOrDefault(row, "dattim1");
            CraetorSid = Db.DbHelper.GetValueString(row, "creator_sid");
            DocsCount = Db.DbHelper.GetValueIntOrDefault(row, "docs_count");
            StateId = Db.DbHelper.GetValueIntOrDefault(row, "id_state");
            State=new DocRequestState() {Id= StateId , Name = Db.DbHelper.GetValueString(row, "request_state_name"), SysName = Db.DbHelper.GetValueString(row, "request_state_sys_name"), IsOut = Db.DbHelper.GetValueBool(row, "request_state_is_out"), IsEnd = Db.DbHelper.GetValueBool(row, "request_state_is_end") };
        }

        public static int Create(string creatorSid, int[] docsIds)
        {
            int id = 0;
            string ids = string.Join(",", docsIds);
            SqlParameter pDocIds = new SqlParameter() { ParameterName = "id_list", SqlValue = ids, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pStateId = new SqlParameter() { ParameterName = "id_state", SqlValue = DocRequestState.GetFirstState().Id, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_create", pDocIds, pCreatorSid, pStateId);
            if (dt.Rows.Count > 0)
            {
                id = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "id");
            }
            
            string message = $"Добрый день.<br />Поступил новый запрос на выдачу документов из архива.<br />Автор запроса {AdHelper.GetUserBySid(creatorSid).ShortName}.<br />Ссылка на запрос - {GetRequestLink(id)}";
            message += $"<p>Список документов:<p>{GetDocListStr(id, true)}</p></p>";

            MessageHelper.SendMailSmtp($"[Архив запрос №{id}] Новый запрос", message, true, AdHelper.GetSpecialistMailList(AdGroup.ArchiveAddDoc));
            return id;
        }

        public static string GetRequestLink(int id)
        {
            string appHost = ConfigurationManager.AppSettings["appHost"];
            string message =$"<a href=\"{appHost}/Request?idReq={id}\">{appHost}/Request?idReq={id}</a>";
            return message;
        }

        public static string GetDocListStr(int id, bool getPlaces = false)
        {
            string message = String.Empty;
            var docs = GetDocumentList(id).OrderBy(x => x.Place.StackNumber).ThenBy(x => x.Place.ShelfNumber).ThenBy(x => x.Place.FolderNumber);
            if (docs.Any())
            {
                message +=
                    "<style type=\"text\\css\">table {border-collapse:collapse; border:1px solid black;} table tr th, table tr td {border:1px solid black; padding: 5px;}</style>";
                message += "<table>";
                message +=
                    "<tr><th>ID</th><th>Тип документа</th><th>№ документа</th><th>Дата документа</th><th>Контрагент</th>" +
                   (getPlaces ? "<th>Стеллаж</th><th>Полка</th><th>Папка</th>":String.Empty) +
                    "</tr>";
                foreach (Document doc in docs)
                {
                    message +=
                        $"<tr style=\"border:1px solid black\"><td>{doc.Id}</td><td>{doc.DocType}</td><td>{doc.DocNumber}</td><td>{doc.DocDate:dd.MM.yyyy}</td><td>{doc.ContractorName}</td>" +
                        (getPlaces ? $"<td>{doc.Place.StackNumber}</td><td>{doc.Place.ShelfNumber}</td><td>{doc.Place.FolderNumber}</td>" : String.Empty) +
                        $"</tr>";
                }
                message += "</table>";
            }
            return message;
        }

        public static void SetWork(string creatorSid, int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id_request", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_state_work", pId, pCreatorSid);
            //ChangeState(creatorSid, id, DocRequestState.GetWorkState().Id);
            string message = $"Добрый день.<br />Документы по запросу №{id} готовы к выдаче.";
            message += $"<br />Ссылка на запрос - {GetRequestLink(id)}";
            message += $"<p>Список документов:<p>{GetDocListStr(id)}</p></p>";
            string authorSid = new DocRequest(id).CraetorSid;
            MessageHelper.SendMailSmtp($"[Архив запрос №{id}] Документы готовы к выдаче", message, true, AdHelper.GetUserBySid(authorSid).Email);
        }

        public static void SetGiven(string creatorSid, int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id_request", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_state_given", pId, pCreatorSid);
            //ChangeState(creatorSid, id, DocRequestState.GetGivenState().Id);
            //ChangeDocumentState(creatorSid, id, DocState.GetOutState().Id);
            //string message = $"Добрый день.<br />Документы по запросу №{id} готовы к выдаче.";
            //message += $"<br />Ссылка на запрос - {GetRequestLink(id)}";
            //message += $"<p>Список документов:<p>{GetDocListStr(id)}</p></p>";
            //string authorSid = new DocRequest(id).CraetorSid;
            //MessageHelper.SendMailSmtp($"[Архив запрос №{id}] Документы готовы к выдаче", message, true, AdHelper.GetUserBySid(authorSid).Email);
        }

        public static void ChangeDocumentState(string creatorSid, int idRequest, int docStateId)
        {
            SqlParameter pIdRequest = new SqlParameter() { ParameterName = "id_request", SqlValue = idRequest, SqlDbType = SqlDbType.Int };
            SqlParameter pDocStateId = new SqlParameter() { ParameterName = "id_doc_state", SqlValue = docStateId, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_change_doc_state", pIdRequest, pCreatorSid, pDocStateId);
        }

        public static void ChangeState(string creatorSid, int id, int stateId)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pStateId = new SqlParameter() { ParameterName = "id_state", SqlValue = stateId, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_change_state", pId, pCreatorSid, pStateId);
        }

        public static IEnumerable<DocRequest> GetList(out int totalCount, int? idReq, string auth, string reqDate, bool activeOnly = true, string doc = null)
        {
            SqlParameter pIdReq = new SqlParameter() { ParameterName = "id", SqlValue = idReq, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pAuth = new SqlParameter() { ParameterName = "author", SqlValue = auth, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pReqDate = new SqlParameter() { ParameterName = "request_date_str", SqlValue = reqDate, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pActiveOnly = new SqlParameter() { ParameterName = "active_only", SqlValue = activeOnly, SqlDbType = SqlDbType.Bit };
            SqlParameter pDocument = new SqlParameter() { ParameterName = "document", SqlValue = doc, SqlDbType = SqlDbType.NVarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_get_list", pIdReq, pAuth, pReqDate, pActiveOnly, pDocument);

            totalCount = 0;
            var lst = new List<DocRequest>();

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var model = new DocRequest(row);
                    lst.Add(model);
                }
                totalCount = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "total_count");
            }
            return lst;
        }

        public static IEnumerable<Document> GetDocumentList(int idRequest)
        {
            return Document.GetRequestList(idRequest);
        }

        public static bool SetDocumentCame(int idDoc, int idReq, string creatorSid)
        {
            //Document.SetArchiveState(idDoc, creatorSid);
            SqlParameter pIdReq = new SqlParameter() { ParameterName = "id_request", SqlValue = idReq, SqlDbType = SqlDbType.Int };
            SqlParameter pIdDoc = new SqlParameter() { ParameterName = "id_document", SqlValue = idDoc, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("request_document_came", pIdReq, pIdDoc, pCreatorSid);
            bool reqDone = false;
            if (dt.Rows.Count > 0)
            {
                reqDone = Db.DbHelper.GetValueBool(dt.Rows[0], "done");
            }
            return reqDone;
        }
    }
}