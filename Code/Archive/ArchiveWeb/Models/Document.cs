using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Claims;
using System.Web;
using ArchiveWeb.Helpers;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Models
{
    public class Document:DbModel
    {
        public int Id { get; set; }
        public int IdContractor { get; set; }
        public string ContractorName { get; set; }
        public int? IdDocType { get; set; }
        public string DocType { get; set; }
        public DateTime DocDate { get; set; }
        public int IdOrganization { get; set; }
        public string Organization { get; set; }
        public string DocNumber { get; set; }
        public int? IdDocState { get; set; }
        public string State { get; set; }
        public DateTime DateCreate { get; set; }
        public int SheetCount { get; set; }

        public Document() { }

        public Document(int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_get", pId);
            if (dt.Rows.Count > 0)
            {
                FillSelf(dt.Rows[0]);
            }
        }

        public Document(DataRow row)
        {
            FillSelf(row);
        }

        public void FillSelf(DataRow row)
        {
            Id = Db.DbHelper.GetValueIntOrDefault(row, "id", "id_document");
            DocDate = Db.DbHelper.GetValueDateTimeOrDefault(row, "doc_date");
            DocNumber = Db.DbHelper.GetValueString(row, "doc_number");
            DateCreate = Db.DbHelper.GetValueDateTimeOrDefault(row, "dattim1");
            SheetCount = Db.DbHelper.GetValueIntOrDefault(row, "sheet_count");
            IdOrganization = Db.DbHelper.GetValueIntOrDefault(row, "id_organization");
            Organization = Db.DbHelper.GetValueString(row, "organization");
            IdDocType = Db.DbHelper.GetValueIntOrDefault(row, "id_doc_type");
            DocType = Db.DbHelper.GetValueString(row, "doc_type");
            IdDocState = Db.DbHelper.GetValueIntOrDefault(row, "id_doc_state");
            State = Db.DbHelper.GetValueString(row, "doc_state");
            IdContractor = Db.DbHelper.GetValueIntOrDefault(row, "id_contractor");
            ContractorName = Db.DbHelper.GetValueString(row, "contractor");
        }

        public static IEnumerable<Document> GetList(int? topRows = null, int? pageNum = null)
        {
            if (!topRows.HasValue) topRows = 30;
            if (!pageNum.HasValue) pageNum = 1;

            SqlParameter pTopRows = new SqlParameter() { ParameterName = "top_rows", SqlValue = topRows, SqlDbType = SqlDbType.Int };
            SqlParameter pPageNum = new SqlParameter() { ParameterName = "page_num", SqlValue = pageNum, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_get_list", pTopRows, pPageNum);

            int cnt = 0;
            var lst = new List<Document>();

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var model = new Document(row);
                    lst.Add(model);
                }
                cnt = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "total_count");
            }
            return lst;
            //var result = new ListResult<Claim>(lst, cnt);
            //return result;
        }

        public int Add()
        {
            SqlParameter pDocDate = new SqlParameter() { ParameterName = "doc_date", SqlValue = DocDate, SqlDbType = SqlDbType.DateTime };
            SqlParameter pDocNumber = new SqlParameter() { ParameterName = "doc_number", SqlValue = DocNumber, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pSheetCount = new SqlParameter() { ParameterName = "sheet_count", SqlValue = SheetCount, SqlDbType = SqlDbType.Int };
            SqlParameter pIdOrganizatione = new SqlParameter() { ParameterName = "id_organization", SqlValue = IdOrganization, SqlDbType = SqlDbType.Int };
            SqlParameter pIdDocType = new SqlParameter() { ParameterName = "id_doc_type", SqlValue = IdDocType, SqlDbType = SqlDbType.Int };
            SqlParameter pIdDocState = new SqlParameter() { ParameterName = "id_doc_state", SqlValue = DocState.GetFirstState().Id, SqlDbType = SqlDbType.Int };
            SqlParameter pIdContractor = new SqlParameter() { ParameterName = "id_contractor", SqlValue = IdContractor, SqlDbType = SqlDbType.Int };
            SqlParameter pContractor = new SqlParameter() { ParameterName = "contractor", SqlValue = Contractor.GetName(IdContractor), SqlDbType = SqlDbType.NVarChar };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = CurUserAdSid, SqlDbType = SqlDbType.VarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_add", pDocDate, pDocNumber, pSheetCount, pIdOrganizatione, pIdDocType, pIdDocState, pCreatorAdSid, pIdContractor, pContractor);
            int id = 0;
            if (dt.Rows.Count > 0)
            {
                int.TryParse(dt.Rows[0]["id"].ToString(), out id);
                Id = id;
            }
            return id;
        }
    }
}