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
    
    public partial class Tbl_QuestionModule
    {
        public Tbl_QuestionModule()
        {
            this.Tbl_QuestionBank = new HashSet<Tbl_QuestionBank>();
        }
    
        public int moduleId { get; set; }
        public string moduleName { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<int> displayOrder { get; set; }
    
        public virtual ICollection<Tbl_QuestionBank> Tbl_QuestionBank { get; set; }
    }
}
