using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ArchiveWeb.Models
{
    public class Document
    {
        public int Id { get; set; }
        public int IdContractor { get; set; }
        public string Contractor { get; set; }
        public int? IdDocType { get; set; }
        public string DocType { get; set; }
        public DateTime DocDate { get; set; }
        public int IdOrganization { get; set; }
        public string Organization { get; set; }
        public string DocNumber { get; set; }
        public int? IdDocState { get; set; }
        public string DocState { get; set; }

    }
}