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
    
    public partial class LU_OwnerDesignation
    {
        public LU_OwnerDesignation()
        {
            this.Tbl_Owner = new HashSet<Tbl_Owner>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Tbl_Owner> Tbl_Owner { get; set; }
    }
}
