using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;

namespace ArchiveWeb.Models
{
    public class Place
    {
        public int Id { get; set; }
        public string IdStake { get; set; }
        public string StackNumber { get; set; }
        public int ShelfNumber { get; set; }
        public int FolderNumber { get; set; }
        public int FolderSheetsCount { get; set; }
        public int FolderSheetsFilledCount { get; set; }
        public int DocumentsCount { get; set; }
        /// <summary>
        /// Сколько листов лежит в данном месте у конкретного документа
        /// </summary>
        public int DocumentSheetsCount { get; set; }

        public Place()
        {
        }

        public static void Fill(int idPlace, int idDocument, string creatorSid)
        {
            SqlParameter pIdPlace = new SqlParameter() { ParameterName = "id_place", SqlValue = idPlace, SqlDbType = SqlDbType.Int };
            SqlParameter pIdDocument = new SqlParameter() { ParameterName = "id_document", SqlValue = idDocument, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("place_fill", pIdPlace, pIdDocument, pCreatorSid);
        }

        public static int GetNew(int idDocument)
        {
            SqlParameter pIdDocument = new SqlParameter() { ParameterName = "id_document", SqlValue = idDocument, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("place_get_new", pIdDocument);
            int id = 0;
            if (dt.Rows.Count > 0)
            {
                id = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "id");
            }
            return id;
        }

        public static void Create(int idStake, string creatorSid)
        {
            SqlParameter pIdStake = new SqlParameter() { ParameterName = "id_stake", SqlValue = idStake, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("place_create", pIdStake, pCreatorAdSid);
        }
    }
}