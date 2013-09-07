using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MSI.CCAT.Data.Models
{
    public class LookUp
    {
        public string Text;
        public string Value;

        public LookUp(string text, string value)
        {
            Text = text;
            Value = value;
        }
    }

    public enum UserRole
    {
        Admin,
        CollectionAgency,
        CollectionLawfirm,
        CreditIssuer,
        DebtOwner,
    }
    public enum ComplaintStatus
    {
        NCRA=1,
        NCIP,
        AAI,
        SFOA,
        ORIP,
        RC,
        BLANK
    }
}
