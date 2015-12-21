using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Data;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;
using DocumentFormat.OpenXml.Wordprocessing;

namespace ArchiveWeb.Models
{
    public class DocStateHistoryItem
    {
        public int Id { get; set; }
        public int IdDocument {get;set;}
        //public Document Document { get; set; }
        public int IdState { get; set; }
        public string StateName { get; set; }
        public DateTime DateCreate { get; set; }
        public string CreatorSid { get; set; }
        public string CreatorName { get; set; }

        public DocStateHistoryItem(DataRow row)
        {
            FillSelf(row);
        }

        private void FillSelf(DataRow row)
        {
            Id = Db.DbHelper.GetValueIntOrDefault(row, "id");
            IdDocument = Db.DbHelper.GetValueIntOrDefault(row, "id_document");
            IdState = Db.DbHelper.GetValueIntOrDefault(row, "id_state");
            StateName = Db.DbHelper.GetValueString(row, "state_name");
            CreatorSid = Db.DbHelper.GetValueString(row, "creator_sid");
            CreatorName = Db.DbHelper.GetValueString(row, "creator_name");
            DateCreate = Db.DbHelper.GetValueDateTimeOrDefault(row, "dattim1");
        }
    }
}