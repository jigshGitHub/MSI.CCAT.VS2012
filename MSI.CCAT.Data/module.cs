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
    
    public partial class module
    {

        public List<int> pageMenuGroups_
        {
            get
            {
                if (String.IsNullOrEmpty(pageMenuGroups))
                    return null;
                else
                {
                    List<String> _strings = new List<string>(pageMenuGroups.Split(','));
                    return _strings.ConvertAll<int>(x => Convert.ToInt32(x));
                }
            }
        }
    }
}