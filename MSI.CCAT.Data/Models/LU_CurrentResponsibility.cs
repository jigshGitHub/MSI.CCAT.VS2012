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
    
    public partial class LU_CurrentResponsibility
    {
        public LU_CurrentResponsibility()
        {
            this.Tbl_PortfolioDetails = new HashSet<Tbl_PortfolioDetails>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Tbl_PortfolioDetails> Tbl_PortfolioDetails { get; set; }
    }
}
