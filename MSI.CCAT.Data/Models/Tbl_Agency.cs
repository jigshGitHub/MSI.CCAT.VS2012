//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MSI.CCAT.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tbl_Agency
    {
        public Tbl_Agency()
        {
            this.Tbl_Account = new HashSet<Tbl_Account>();
            this.Tbl_ComplaintMain = new HashSet<Tbl_ComplaintMain>();
        }
    
        public int AgencyId { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public string City { get; set; }
        public Nullable<int> StateId { get; set; }
        public Nullable<int> OwnerId { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Zipcode { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string AgencyContact_LastName { get; set; }
        public string AgencyContact_FirstName { get; set; }
        public string AgencyContact_Email { get; set; }
        public Nullable<System.DateTime> UpdatedOn { get; set; }
        public string UpdatedBy { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public string CreatedBy { get; set; }
    
        public virtual ICollection<Tbl_Account> Tbl_Account { get; set; }
        public virtual Tbl_Owner Tbl_Owner { get; set; }
        public virtual Tbl_States Tbl_States { get; set; }
        public virtual ICollection<Tbl_ComplaintMain> Tbl_ComplaintMain { get; set; }
    }
}
