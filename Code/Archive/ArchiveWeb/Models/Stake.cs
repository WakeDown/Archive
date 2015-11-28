using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;

namespace ArchiveWeb.Models
{
    public class Stake
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public int OrderNum { get; set; }
        public int ShelfCount { get; set; }
        public int ShelfFoldersCount { get; set; }
        public int FolderCount => ShelfCount*ShelfFoldersCount;
        public int FolderSheetsCount { get; set; }

        public int ShelfsEmpty => ShelfCount - ShelfsFilled;
        public int ShelfsFilled { get; set; }
        public int FoldersEmpty => FolderCount - FoldersFilled;
        public int FoldersFilled { get; set; }
        public string Descr { get; set; }

        public int DocuemntCount { get; set; }


        public Stake()
        {
        }

        public Stake(bool setDefultValues)
        {
            if (setDefultValues)//Значения по умолчанию
            {
                OrderNum = GetNewOrderNum();
                Number = OrderNum.ToString();
                ShelfCount = 6;
                ShelfFoldersCount = 11;
                FolderSheetsCount = 500;
            }
        }

        public Stake(int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("stake_get", pId);
            if (dt.Rows.Count > 0)
            {
                FillSelf(dt.Rows[0]);
            }
        }

        public Stake(DataRow row)
        {
            FillSelf(row);
        }

        public void FillSelf(DataRow row)
        {
            Id = Db.DbHelper.GetValueIntOrDefault(row, "id");
            Number = Db.DbHelper.GetValueString(row, "number");
            OrderNum = Db.DbHelper.GetValueIntOrDefault(row, "order_num");
            ShelfCount = Db.DbHelper.GetValueIntOrDefault(row, "shelf_count");
            ShelfFoldersCount = Db.DbHelper.GetValueIntOrDefault(row, "shelf_folders_count");
            //FolderCount = Db.DbHelper.GetValueIntOrDefault(row, "folder_count");
            //ShelfsEmpty = Db.DbHelper.GetValueIntOrDefault(row, "shelfs_empty");
            ShelfsFilled = Db.DbHelper.GetValueIntOrDefault(row, "shelfs_filled");
            //FoldersEmpty = Db.DbHelper.GetValueIntOrDefault(row, "folders_empty");
            FoldersFilled = Db.DbHelper.GetValueIntOrDefault(row, "folders_filled");
            FolderSheetsCount = Db.DbHelper.GetValueIntOrDefault(row, "folder_sheets_count");
            Descr = Db.DbHelper.GetValueString(row, "descr");
            DocuemntCount = Db.DbHelper.GetValueIntOrDefault(row, "document_count");
        }

        public static IEnumerable<Stake> GetList(out int totalCount)
        {
            //SqlParameter pTopRows = new SqlParameter() { ParameterName = "top_rows", SqlValue = topRows, SqlDbType = SqlDbType.Int };
            //SqlParameter pPageNum = new SqlParameter() { ParameterName = "page_num", SqlValue = pageNum, SqlDbType = SqlDbType.Int };
            
            var dt = Db.Archive.ExecuteQueryStoredProcedure("stake_get_list");

            totalCount = 0;
            var lst = new List<Stake>();

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    var model = new Stake(row);
                    lst.Add(model);
                }
                totalCount = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "total_count");
            }
            return lst;
        }

        public int Create(string creatorSid)
        {
            SqlParameter pNumber = new SqlParameter() { ParameterName = "number", SqlValue = Number, SqlDbType = SqlDbType.NVarChar };
            SqlParameter pOrderNum = new SqlParameter() { ParameterName = "order_num", SqlValue = OrderNum, SqlDbType = SqlDbType.Int };
            SqlParameter pShelfCount = new SqlParameter() { ParameterName = "shelf_count", SqlValue = ShelfCount, SqlDbType = SqlDbType.Int };
            SqlParameter pShelfFoldersCount = new SqlParameter() { ParameterName = "shelf_folders_count", SqlValue = ShelfFoldersCount, SqlDbType = SqlDbType.Int };
            SqlParameter pFolderCount = new SqlParameter() { ParameterName = "folder_count", SqlValue = FolderCount, SqlDbType = SqlDbType.Int };
            SqlParameter pFolderSheetsCount = new SqlParameter() { ParameterName = "folder_sheets_count", SqlValue = FolderSheetsCount, SqlDbType = SqlDbType.Int };
            SqlParameter pCreatorAdSid = new SqlParameter() { ParameterName = "creator_sid", SqlValue = creatorSid, SqlDbType = SqlDbType.VarChar };
            SqlParameter pDescr = new SqlParameter() { ParameterName = "descr", SqlValue = Descr, SqlDbType = SqlDbType.NVarChar };

            var dt = Db.Archive.ExecuteQueryStoredProcedure("stake_create", pNumber, pOrderNum, pShelfCount, pShelfFoldersCount, pFolderCount, pFolderSheetsCount, pCreatorAdSid, pDescr);
            int id = 0;
            if (dt.Rows.Count > 0)
            {
                int.TryParse(dt.Rows[0]["id"].ToString(), out id);
                Id = id;
            }

            Place.Create(Id, creatorSid);

            return id;
        }
        
        public int GetNewOrderNum()
        {
            var dt = Db.Archive.ExecuteQueryStoredProcedure("stake_get_new_order_num");
            int orderNum = 500;
            if (dt.Rows.Count > 0)
            {
                orderNum = Db.DbHelper.GetValueIntOrDefault(dt.Rows[0], "order_num");
            }
            return orderNum;
        }
    }
}