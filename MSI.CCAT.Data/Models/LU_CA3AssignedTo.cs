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
    
    public partial class LU_CA3AssignedTo
    {
        public LU_CA3AssignedTo()
        {
            this.Tbl_ComplaintMain = new HashSet<Tbl_ComplaintMain>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Tbl_ComplaintMain> Tbl_ComplaintMain { get; set; }
    }
}
