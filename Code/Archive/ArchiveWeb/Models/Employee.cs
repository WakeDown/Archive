using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using ArchiveWeb.Helpers;

namespace ArchiveWeb.Models
{
    public class Employee
    {
        public static IEnumerable<KeyValuePair<string, string>> GetOutSelectionList(string name = null)
        {
            SqlParameter pName = new SqlParameter() { ParameterName = "name", SqlValue = name, SqlDbType = SqlDbType.NVarChar };
            var dt = Db.Archive.ExecuteQueryStoredProcedure("employee_get_out_list", pName);
            var lst = new List<KeyValuePair<string, string>>();
            foreach (DataRow row in dt.Rows)
            {
                var item = new KeyValuePair<string, string>(Db.DbHelper.GetValueString(row, "sid"), Db.DbHelper.GetValueString(row, "name"));
                lst.Add(item);
            }
            return lst;
        } 
    }
}