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
        public Nullable<System.Guid> AgencyCollectorUserId { get; set; }
        public Nullable<int> LU_Stakeholder3Id { get; set; }
        public Nullable<int> LU_CA2RecommendationId { get; set; }
        public Nullable<int> LU_CA3RecommendationId { get; set; }
        public string CA1Audience { get; set; }
        public Nullable<System.DateTime> Date_CA1 { get; set; }
        public Nullable<int> LU_CA1ViolationId { get; set; }
        public Nullable<int> LU_CA1RootCauseId { get; set; }
        public Nullable<int> LU_CA1RecommendationId { get; set; }
        public Nullable<int> LU_CA1AssignedToId { get; set; }
        public Nullable<System.DateTime> Date_CA1ReportBack { get; set; }
        public Nullable<bool> YN_CA1Followed { get; set; }
        public Nullable<System.DateTime> Date_CA1Administered { get; set; }
        public Nullable<bool> YN_CA1StateLawApplicable { get; set; }
        public string Notes_CA1 { get; set; }
        public string CA2Audience { get; set; }
        public Nullable<System.DateTime> Date_CA2 { get; set; }
        public Nullable<int> LU_CA2ViolationId { get; set; }
        public Nullable<int> LU_CA2RootCauseId { get; set; }
        public Nullable<int> LU_CA2AssignedToId { get; set; }
        public Nullable<System.DateTime> Date_CA2ReportBack { get; set; }
        public Nullable<bool> YN_CA2Followed { get; set; }
        public Nullable<System.DateTime> Date_CA2Administered { get; set; }
        public Nullable<bool> YN_CA2StateLawApplicable { get; set; }
        public string Notes_CA2 { get; set; }
        public string CA3Audience { get; set; }
        public Nullable<System.DateTime> Date_CA3 { get; set; }
        public Nullable<int> LU_CA3ViolationId { get; set; }
        public Nullable<int> LU_CA3RootCauseId { get; set; }
        public Nullable<int> LU_CA3AssignedToId { get; set; }
        public Nullable<System.DateTime> Date_CA3ReportBack { get; set; }
        public Nullable<bool> YN_CA3Followed { get; set; }
        public Nullable<System.DateTime> Date_CA3Administered { get; set; }
        public Nullable<bool> YN_C32StateLawApplicable { get; set; }
        public string Notes_CA3 { get; set; }
        public Nullable<int> LU_ComplaintIntakeStatusId { get; set; }
        public Nullable<System.DateTime> Date_RequiredResolution { get; set; }
        public Nullable<int> LU_ComplaintClassificationId { get; set; }
        public Nullable<int> LU_ComplaintCategoryId { get; set; }
        public string SourceReferenceNumber { get; set; }
        public string IfAttorney { get; set; }
        public Nullable<int> LU_ComplaintAgainstId { get; set; }
        public Nullable<int> LU_ViolationAllegedId { get; set; }
        public Nullable<int> LU_Allegation1Id { get; set; }
        public Nullable<int> LU_Allegation2Id { get; set; }
        public string PortfolioId { get; set; }
        public Nullable<int> LU_OwnershipStatusId { get; set; }
        public Nullable<int> LU_ResolutionRequestId { get; set; }
        public string Notes_ComplaintIntake { get; set; }
        public Nullable<int> LU_RootCause1Id { get; set; }
        public Nullable<bool> YN_Improvement1 { get; set; }
        public Nullable<bool> YN_ReferenceCA1 { get; set; }
        public Nullable<int> LU_Stakeholder1Id { get; set; }
        public Nullable<int> LU_RootCause2Id { get; set; }
        public Nullable<bool> YN_Improvement2 { get; set; }
        public Nullable<bool> YN_ReferForCA2 { get; set; }
        public Nullable<int> LU_Stakeholder2Id { get; set; }
        public Nullable<int> LU_RootCause3Id { get; set; }
        public Nullable<bool> YN_IsIssueValid { get; set; }
        public string Notes_Investivation { get; set; }
        public Nullable<System.DateTime> Date_Resolution { get; set; }
        public string Resolution { get; set; }
        public Nullable<bool> YN_DisputeResolution { get; set; }
        public Nullable<decimal> AccountClosedBalance { get; set; }
        public Nullable<decimal> Damages { get; set; }
        public Nullable<decimal> OurAttorneyFees { get; set; }
        public Nullable<decimal> OtherCosts { get; set; }
        public Nullable<decimal> TotalCost { get; set; }
        public string Notes_Resolution { get; set; }
    
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
        public virtual aspnet_Users aspnet_Users { get; set; }
        public virtual LU_Allegation1 LU_Allegation1 { get; set; }
        public virtual LU_Allegation2 LU_Allegation2 { get; set; }
        public virtual LU_CA1AssignedTo LU_CA1AssignedTo { get; set; }
        public virtual LU_CA1Recommendation LU_CA1Recommendation { get; set; }
        public virtual LU_CA1RootCause LU_CA1RootCause { get; set; }
        public virtual LU_CA1Violation LU_CA1Violation { get; set; }
        public virtual LU_CA2AssignedTo LU_CA2AssignedTo { get; set; }
        public virtual LU_CA2Recommendation LU_CA2Recommendation { get; set; }
        public virtual LU_CA2RootCause LU_CA2RootCause { get; set; }
        public virtual LU_CA2Violation LU_CA2Violation { get; set; }
        public virtual LU_CA3AssignedTo LU_CA3AssignedTo { get; set; }
        public virtual LU_CA3Recommendation LU_CA3Recommendation { get; set; }
        public virtual LU_CA3RootCause LU_CA3RootCause { get; set; }
        public virtual LU_CA3Violation LU_CA3Violation { get; set; }
        public virtual LU_ComplaintAgainst LU_ComplaintAgainst { get; set; }
        public virtual LU_ComplaintCategory LU_ComplaintCategory { get; set; }
        public virtual LU_ComplaintClassification LU_ComplaintClassification { get; set; }
        public virtual LU_ComplaintIntakeStatus LU_ComplaintIntakeStatus { get; set; }
        public virtual LU_OwnershipStatus LU_OwnershipStatus { get; set; }
        public virtual LU_ResolutionRequest LU_ResolutionRequest { get; set; }
        public virtual LU_RootCause1 LU_RootCause1 { get; set; }
        public virtual LU_RootCause2 LU_RootCause2 { get; set; }
        public virtual LU_RootCause3 LU_RootCause3 { get; set; }
        public virtual LU_Stakeholder1 LU_Stakeholder1 { get; set; }
        public virtual LU_Stakeholder2 LU_Stakeholder2 { get; set; }
        public virtual LU_Stakeholder3 LU_Stakeholder3 { get; set; }
        public virtual LU_ViolationAlleged LU_ViolationAlleged { get; set; }
    }
}
