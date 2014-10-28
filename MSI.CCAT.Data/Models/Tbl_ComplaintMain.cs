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
    
    public partial class Tbl_ComplaintMain
    {
        public string ComplaintId { get; set; }
        public Nullable<System.DateTime> ComplaintDate { get; set; }
        public Nullable<int> ReceivedByMethodId { get; set; }
        public Nullable<int> IssuesId { get; set; }
        public string ComplaintNotes { get; set; }
        public string ComplaintDocument { get; set; }
        public Nullable<bool> ComplaintSubmittedToAgencyYN { get; set; }
        public Nullable<System.DateTime> ComplaintSubmittedToAgencyDate { get; set; }
        public Nullable<bool> MoreInfoReqdFromDebtorYN { get; set; }
        public Nullable<System.DateTime> MoreInfoRequestedDate { get; set; }
        public string MoreInfoRequested { get; set; }
        public Nullable<bool> MoreInfoReceivedFromDebtorYN { get; set; }
        public Nullable<System.DateTime> MoreInfoReceivedDate { get; set; }
        public string MoreInfoReceived { get; set; }
        public Nullable<bool> ComplaintSubmittedToOwnerYN { get; set; }
        public Nullable<System.DateTime> ComplaintSubmittedDate { get; set; }
        public Nullable<int> TimeToSubmitDays { get; set; }
        public string DebtOwnerProcessDocument { get; set; }
        public Nullable<bool> MoreInfoFromAgencyYN { get; set; }
        public Nullable<System.DateTime> MoreInfoFromAgencyRequestedDate { get; set; }
        public string MoreInfoFromAgencyRequested { get; set; }
        public Nullable<bool> MoreInfoFromAgencyReceivedYN { get; set; }
        public Nullable<System.DateTime> MoreInfoFromAgencyReceivedDate { get; set; }
        public string MoreInfoFromAgencyReceived { get; set; }
        public Nullable<int> OwnerResponseId { get; set; }
        public Nullable<System.DateTime> OwnerResponseDate { get; set; }
        public Nullable<int> OwnerResponseDays { get; set; }
        public Nullable<System.DateTime> AgencyResponseToDebtorDate { get; set; }
        public Nullable<int> TotalResponseTimeDays { get; set; }
        public Nullable<bool> DebtorAgreeYN { get; set; }
        public Nullable<bool> NeedFurtherActionYN { get; set; }
        public Nullable<int> FinalActionStepId { get; set; }
        public Nullable<bool> DebtorIdentityVerifiedYN { get; set; }
        public Nullable<int> DebtorContactMethodId { get; set; }
        public Nullable<int> DebtorContactTimeId { get; set; }
        public Nullable<int> DebtorProductId { get; set; }
        public Nullable<bool> DisputeDebtYN { get; set; }
        public Nullable<bool> DisputeDebtAmountYN { get; set; }
        public Nullable<bool> DisputeDebtDueDateYN { get; set; }
        public string AccountNumber { get; set; }
        public Nullable<int> ComplaintStatusId { get; set; }
        public Nullable<bool> IsViewedByOwner { get; set; }
        public Nullable<bool> IsViewedByAgency { get; set; }
        public Nullable<System.Guid> CreatedBy { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.Guid> UpdatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDateTime { get; set; }
        public Nullable<System.DateTime> UpdatedDateTime { get; set; }
        public Nullable<int> ComplaintTypeID { get; set; }
    
        public virtual Tbl_Account Tbl_Account { get; set; }
        public virtual Tbl_ComplaintIssues Tbl_ComplaintIssues { get; set; }
        public virtual Tbl_ComplaintReceivedBy Tbl_ComplaintReceivedBy { get; set; }
        public virtual Tbl_DebtorContactMethods Tbl_DebtorContactMethods { get; set; }
        public virtual Tbl_DebtorContactTime Tbl_DebtorContactTime { get; set; }
        public virtual Tbl_DebtorProducts Tbl_DebtorProducts { get; set; }
        public virtual Tbl_FinalActionSteps Tbl_FinalActionSteps { get; set; }
        public virtual Tbl_OwnerResponses Tbl_OwnerResponses { get; set; }
        public virtual Tbl_ComplaintStatus Tbl_ComplaintStatus { get; set; }
        public virtual Tbl_ComplaintType Tbl_ComplaintType { get; set; }
    }
}
