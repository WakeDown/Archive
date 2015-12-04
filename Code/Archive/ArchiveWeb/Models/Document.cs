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
        public string ContractorUid { get; set; }
        public string ContractorName { get; set; }
        public int? IdDocType { get; set; }
        public string DocType { get; set; }
        public DateTime DocDate { get; set; }
        public int IdOrganization { get; set; }
        public string OrganizationUid { get; set; }
        public string Organization { get; set; }
        public string DocNumber { get; set; }
        public int? IdDocState { get; set; }
        public string State { get; set; }
        public string DocStateSysName { get; set; }
        public DateTime DateCreate { get; set; }
        public int SheetCount { get; set; }
        
        public Place Place { get; set; }

        public string Surname { get; set; }
        public string Name { get; set; }
        public string Patronymic { get; set; }


        /// <summary>
        /// Стеллаж
        /// </summary>
        public string Stack { get; set; }
        /// <summary>
        /// Полка
        /// </summary>
        public string Shelf { get; set; }
        /// <summary>
        /// Папка
        /// </summary>
        public string Folder { get; set; }
        public DateTime? DateStateChange { get; set; }
        public string StateChangerName { get; set; }
        public string CreatorName { get; set; }
        public string WhoGetName { get; set; }
        public byte[] FileData { get; set; }
        public string FileName { get; set; }
        public string FileSid { get; set; }
        public bool Enabled { get; set; }

        public Document() { }

        public Document(int id, bool t2cardView = false)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pT2CardView = new SqlParameter() { ParameterName = "t2card_view", SqlValue = t2cardView, SqlDbType = SqlDbType.Bit };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_get", pId, pT2CardView);
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
            Stack = Db.DbHelper.GetValueString(row, "stack");
            Shelf = Db.DbHelper.GetValueString(row, "shelf");
            Folder = Db.DbHelper.GetValueString(row, "folder");
            DocStateSysName = Db.DbHelper.GetValueString(row, "doc_state_sys_name");
            DateStateChange = Db.DbHelper.GetValueDateTimeOrNull(row, "date_state_change");
            StateChangerName= Db.DbHelper.GetValueString(row, "state_changer_name");
            CreatorName = Db.DbHelper.GetValueString(row, "creator_name");
            WhoGetName = Db.DbHelper.GetValueString(row, "who_get_name");
            FileName = Db.DbHelper.GetValueString(row, "file_name");
            FileSid = Db.DbHelper.GetValueString(row, "file_sid");
            Enabled = Db.DbHelper.GetValueBool(row, "enabled");
            ContractorUid = Db.DbHelper.GetValueString(row, "contractor_uid");
            OrganizationUid = Db.DbHelper.GetValueString(row, "organization_uid");
            Surname = Db.DbHelper.GetValueString(row, "surname");
            Name = Db.DbHelper.GetValueString(row, "name");
            Patronymic = Db.DbHelper.GetValueString(row, "patronymic");

            Place = new Place() {StackNumber = Db.DbHelper.GetValueString(row, "place_stack"),ShelfNumber = Db.DbHelper.GetValueIntOrDefault(row, "place_shelf"), FolderNumber = Db.DbHelper.GetValueIntOrDefault(row, "place_folder") };
        }

        public static IEnumerable<Document> GetList(out int totalCount, int? topRows = null, int? pageNum = null, string docNum = null, string docDate=null, string docType = null, string dateCreate = null, string state = null, string place = null, string id = null, string contractor = null, bool t2cardView = false)
        {
            if (!topRows.HasValue) topRows = 30;
            if (!pageNum.HasValue) pageNum = 1;

            SqlParameter pTopRows = new SqlParameter() { ParameterName = "top_rows", SqlValue = topRows, SqlDbType = SqlDbType.Int };
            SqlParameter pPageNum = new SqlParameter() { ParameterName = "page_num", SqlValue = pageNum, SqlDbType = SqlDbType.Int };
            SqlParameter pDocNum = new SqlParameter() { ParameterName = "doc_number", SqlValue = docNum, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pDocDate = new SqlParameter() { ParameterName = "doc_date_str", SqlValue = docDate, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pDocType = new SqlParameter() { ParameterName = "doc_type_str", SqlValue = docType, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pDateCreate = new SqlParameter() { ParameterName = "date_create_str", SqlValue = dateCreate, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pState = new SqlParameter() { ParameterName = "state", SqlValue = state, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pPlace = new SqlParameter() { ParameterName = "place", SqlValue = place, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pContractor = new SqlParameter() { ParameterName = "contractor", SqlValue = contractor, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pT2CardView = new SqlParameter() { ParameterName = "t2card_view", SqlValue = t2cardView, SqlDbType = SqlDbType.Bit };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_get_list", pTopRows, pPageNum, pDocNum, pDocDate, pDocType, pDateCreate, pState, pPlace, pId, pContractor, pT2CardView);

            totalCount = 0;
            var lst = new List<Document>();

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var model = new Document(row);
                    lst.Add(model);
                }
                totalCount = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "total_count");
            }
            return lst;
            //var result = new ListResult<Claim>(lst, cnt);
            //return result;
        }

        public static IEnumerable<Document> GetListBackup()
        {
            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_get_list_backup");

            
            var lst = new List<Document>();

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var model = new Document(row);
                    lst.Add(model);
                }
            }
            return lst;
        }

        public int Add(string creatorSid)
        {
            if (SheetCount > 500)
            {
                throw new ArgumentException("Нельзя добавить докумнет больше 500 листов. Обратитесь к администратору системы! Документ не был сохранен!");
            }

            SqlParameter pDocDate = new SqlParameter() { ParameterName = "doc_date", SqlValue = DocDate, SqlDbType = SqlDbType.DateTime };
            SqlParameter pDocNumber = new SqlParameter() { ParameterName = "doc_number", SqlValue = DocNumber, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pSheetCount = new SqlParameter() { ParameterName = "sheet_count", SqlValue = SheetCount, SqlDbType = SqlDbType.Int };
            SqlParameter pIdOrganization = new SqlParameter() { ParameterName = "id_organization", SqlValue = IdOrganization, SqlDbType = SqlDbType.Int };
            SqlParameter pOrganization = new SqlParameter() { ParameterName = "organization", SqlValue = Contractor.GetName(OrganizationUid), SqlDbType = SqlDbType.NVarChar };
            SqlParameter pIdDocType = new SqlParameter() { ParameterName = "id_doc_type", SqlValue = IdDocType, SqlDbType = SqlDbType.Int };
            SqlParameter pIdDocState = new SqlParameter() { ParameterName = "id_doc_state", SqlValue = DocState.GetFirstState().Id, SqlDbType = SqlDbType.Int };
            SqlParameter pIdContractor = new SqlParameter() { ParameterName = "id_contractor", SqlValue = IdContractor, SqlDbType = SqlDbType.Int };
            SqlParameter pContractor = new SqlParameter() { ParameterName = "contractor", SqlValue = Contractor.GetName(ContractorUid), SqlDbType = SqlDbType.NVarChar };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pFile = new SqlParameter() { ParameterName = "file", SqlValue = FileData, SqlDbType = SqlDbType.VarBinary };
            SqlParameter pFileName = new SqlParameter() { ParameterName = "file_name", SqlValue = FileName, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pContractorUid = new SqlParameter() { ParameterName = "contractor_uid", SqlValue = ContractorUid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pOrganizationUid = new SqlParameter() { ParameterName = "organization_uid", SqlValue = OrganizationUid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pSurname = new SqlParameter() { ParameterName = "surname", SqlValue = Surname, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pName = new SqlParameter() { ParameterName = "name", SqlValue = Name, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pPatronymic = new SqlParameter() { ParameterName = "patronymic", SqlValue = Patronymic, SqlDbType = SqlDbType.NVarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_add", pDocDate, pDocNumber, pSheetCount, pIdOrganization, pIdDocType, pIdDocState, pCreatorAdSid, pIdContractor, pContractor, pOrganization, pFile, pFileName, pContractorUid, pOrganizationUid, pSurname, pName, pPatronymic);
            
            if (dt.Rows.Count > 0)
            {
                Id = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "id");
                bool alredyExists = Db.DbHelper.GetValueBool(dt.Rows[0], "exists");
                if (alredyExists) return -999;
                else if (Id > 0)
                {
                    int idPlace = Place.GetNew(Id);
                    Place.Fill(idPlace, Id, creatorSid);
                    SetArchiveState(Id, creatorSid);
                }


            }

            

            return Id;
        }

        public void Update(string creatorSid)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = Id, SqlDbType = SqlDbType.Int };
            SqlParameter pStack = new SqlParameter() { ParameterName = "stack", SqlValue = Stack, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pShelf = new SqlParameter() { ParameterName = "shelf", SqlValue = Shelf, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pFolder = new SqlParameter() { ParameterName = "folder", SqlValue = Folder, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pFile = new SqlParameter() { ParameterName = "file", SqlValue = FileData, SqlDbType = SqlDbType.VarBinary };
            SqlParameter pFileName = new SqlParameter() { ParameterName = "file_name", SqlValue = FileName, SqlDbType = SqlDbType.VarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_update", pId, pStack, pShelf, pFolder, pCreatorAdSid, pFile, pFileName);
        }

        public static void SetOutState(int id, string whoGetSid, string creatorSid)
        {
            SetState(id, DocState.GetOutState().Id, creatorSid, whoGetSid);
        }

        public static void SetArchiveState(int id, string creatorSid)
        {
            SetState(id, DocState.GetArchiveState().Id, creatorSid);
        }

        public static void SetState(int id, int idState, string creatorSid, string whoGetSid = null)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pIdState = new SqlParameter() { ParameterName = "id_state", SqlValue = idState, SqlDbType = SqlDbType.Int };
            SqlParameter pWhoGetSid = new SqlParameter() { ParameterName = "who_get_sid", SqlValue = whoGetSid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("document_set_state", pId, pIdState, pCreatorAdSid, pWhoGetSid);
        }
        
        public static byte[] GetFileData(string sid)
        {
            SqlParameter pSid = new SqlParameter() { ParameterName = "sid", SqlValue = sid, SqlDbType = SqlDbType.NVarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("doc_file_get", pSid);
            byte[] data = new byte[0];
            if (dt.Rows.Count > 0)
            {
                data = Db.DbHelper.GetByteArr(dt.Rows[0], "data");
            }
            return data;
        }

        public static void DeleteFile(string sid, string creatorSid)
        {
            SqlParameter pSid = new SqlParameter() { ParameterName = "sid", SqlValue = sid, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("doc_file_close", pSid, pCreatorAdSid);
        }

        public static void Delete(int id, string creatorSid)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("doc_close", pId, pCreatorAdSid);
        }
    }
}