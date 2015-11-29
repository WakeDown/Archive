using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Web;
using ArchiveWeb.Helpers;
using ArchiveWeb.Objects;

namespace ArchiveWeb.Models
{
    public class AdUser
    {
        public string Sid { get; set; }
        //public IPrincipal User { get; set; }
        public string Login { get; set; }

        private string _fullName;
        public string FullName
        {
            get
            {
                return _fullName;
            }
            set
            {
                _fullName = value;
                ShortName = GetShortName(_fullName);
            }
        }

        public string Email { get; set; }
        public string ShortName{get; set;}

        public List<AdGroup> AdGroups { get; set; }

        private static string GetShortName(string name)
        {
            if (String.IsNullOrEmpty(name)) return "Имя отсутствует";
            var shortName = new StringBuilder();
            string res = String.Empty;
            var partNames = name.Split(new[] { " " }, StringSplitOptions.RemoveEmptyEntries);
            if (partNames.Count() > 2)
            {
                shortName.Append(partNames[0]);
                shortName.Append(" ");
                shortName.Append(partNames[1].Substring(0, 1));
                shortName.Append(".");
                shortName.Append(partNames[2].Substring(0, 1));
                shortName.Append(".");

                res = shortName.ToString();
            }
            else if (partNames.Count() == 2)
            {
                shortName.Append(partNames[0]);
                shortName.Append(" ");
                shortName.Append(partNames[1].Substring(0, 1));
                shortName.Append(".");

                res = shortName.ToString();
            }
            else
            {
                res = name;
            }
            return res;
        }

        public bool Is(params AdGroup[] groups)
        {
            return groups.Select(grp => AdGroups.Contains(grp)).Any(res => res);
            //return AdHelper.UserIs(Login, groups);
        }

        public bool HasAccess(params AdGroup[] groups)
        {
            if (AdGroups == null || !AdGroups.Any()) return false;
            if (AdGroups.Contains(AdGroup.SuperAdmin)) return true;
            return groups.Select(grp => AdGroups.Contains(grp)).Any(res => res);
            //return AdHelper.UserInGroup(Login, groups);
        }
    }
}