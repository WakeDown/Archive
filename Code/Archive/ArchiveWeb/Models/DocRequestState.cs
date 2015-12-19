using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;

namespace ArchiveWeb.Models
{
    public class DocRequestState
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string SysName { get; set; }
        public int OrderNum { get; set; }
        public string BackgroundColor { get; set; }
        public string ForegroundColor { get; set; }

        public bool IsOut { get; set; }
        public bool IsEnd { get; set; }

        public DocRequestState() { }

        public DocRequestState(int id)
        {
            SqlParameter pId = new SqlParameter() { ParameterName = "id", SqlValue = id, SqlDbType = SqlDbType.Int };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("doc_request_state_get", pId);
            if (dt.Rows.Count > 0)
            {
                var row = dt.Rows[0];
                FillSelf(row);
            }
        }

        public DocRequestState(string sysName)
        {
            SqlParameter pSysName = new SqlParameter() { ParameterName = "sys_name", SqlValue = sysName, SqlDbType = SqlDbType.NVarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("doc_request_state_get", pSysName);
            if (dt.Rows.Count > 0)
            {
                var row = dt.Rows[0];
                FillSelf(row);
            }
        }

        public DocRequestState(DataRow row)
            : this()
        {
            FillSelf(row);
        }

        private void FillSelf(DataRow row)
        {
            Id = Db.DbHelper.GetValueIntOrDefault(row, "id");
            Name = Db.DbHelper.GetValueString(row, "name");
            SysName = Db.DbHelper.GetValueString(row, "sys_name");
            OrderNum = Db.DbHelper.GetValueIntOrDefault(row, "order_num");
            BackgroundColor = Db.DbHelper.GetValueString(row, "background_color");
            ForegroundColor = Db.DbHelper.GetValueString(row, "foreground_color");
            IsOut = Db.DbHelper.GetValueBool(row, "is_out");
            IsEnd = Db.DbHelper.GetValueBool(row, "is_end");
        }
        
        internal static DocRequestState GetFirstState()
        {
            return GetSentState();
        }

        internal static DocRequestState GetSentState()
        {
            return new DocRequestState("SENT");
        }

        internal static DocRequestState GetWorkState()
        {
            return new DocRequestState("WORK");
        }

        internal static DocRequestState GetDoneState()
        {
            return new DocRequestState("DONE");
        }

        internal static DocRequestState GetGivenState()
        {
            return new DocRequestState("GIVEN");
        }
    }
}