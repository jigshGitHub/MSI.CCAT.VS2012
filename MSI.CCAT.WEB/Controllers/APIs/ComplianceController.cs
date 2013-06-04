﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Data.Models;
using Cascade.Data.Models;
using Cascade.Data.Repositories;
using MSI.CCAT.Data.Repositories;
namespace Cascade.Web.Controllers
{
    public class DebtorsController : ApiController
    {
        public IEnumerable<MSI_Debtor> Get(string accountNumber)
        {
            IEnumerable<MSI_Debtor> debtors = null;

            try
            {
                DataQueries query = new DataQueries();
                debtors = query.GetDebtors(accountNumber);
            }
            catch (Exception ex)
            {
            }
            return debtors;
        }
    }
    public class ComplianceController : ApiController
    {
        private void PopulateDebtInfo(MSI_Debtor debtor, MSI_ComplaintMain complaint)
        {
            complaint.Account = debtor.Account;
            complaint.FirstName = debtor.FirstName;
            complaint.LastName = debtor.LastName;
            complaint.Address = debtor.Address1 + " " + debtor.Address2;
            complaint.City = debtor.City;
            complaint.State = debtor.State;
            complaint.Zip = debtor.Zip;
            complaint.LastFourSSN = debtor.LastFourSSN;
            complaint.MobilePhone = debtor.MobilePhone;
            complaint.HomePhone = debtor.HomePhone;
            complaint.WorkPhone = debtor.WorkPhone;
            complaint.DebtCurrentBalance = debtor.DebtCurrentBalance;
            complaint.DebtPurchaseBalance = debtor.DebtPurchaseBalance;
            complaint.CreditorName = debtor.CreditorName;
        }

        public MSI_ComplaintMain Get(string accountNumber, string agencyId="", string userRole="")
        {
           // MSI_ComplaintMainRepository repository = null;
            UnitOfWork uo = null;
            MSI_ComplaintMain complaint = null; ;
            try
            {

                //repository = new MSI_ComplaintMainRepository();
                uo = new UnitOfWork("CascadeDBEntities");
                IEnumerable<MSI_ComplaintMain> data = (from existingComplaint in uo.Repository<MSI_ComplaintMain>().GetAll().Where(record => record.AgencyId == agencyId && record.Account == accountNumber)
                                                       select existingComplaint);

                if (data.Count() > 0)
                {
                    complaint = data.First();
                    if (!string.IsNullOrEmpty(userRole))
                    {
                        if (userRole == "user")
                            complaint.IsViewedByOwner = true;
                        if (userRole == "agency")
                            complaint.IsViewedByAgency = true;
                        uo.Repository<MSI_ComplaintMain>().Update(complaint);
                    }
                }
                else
                {
                    complaint = new MSI_ComplaintMain();
                    complaint.AgencyId = agencyId;
                    complaint.ComplaintDate = DateTime.Now;
                    IEnumerable<MSI_Debtor> debtors = null;
                    DataQueries query = new DataQueries();
                    debtors = query.GetDebtors(accountNumber);

                    PopulateDebtInfo(debtors.First(), complaint);
                    //PopulateComplaintID(complaint);
                }
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException validationException)
            {
                foreach (System.Data.Entity.Validation.DbEntityValidationResult errorResult in validationException.EntityValidationErrors)
                {
                    foreach (System.Data.Entity.Validation.DbValidationError error in errorResult.ValidationErrors)
                    {
                        string data = error.ErrorMessage;
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return complaint;
        }

        public MSI_ComplaintMain Post(MSI_ComplaintMain complaint)
        {
            MSI_ComplaintMain complaintToSave = null;
            //MSI_ComplaintMainRepository repository = null;
            UnitOfWork uo = null;
            bool editingRequired = true;
            try
            {

               // repository = new MSI_ComplaintMainRepository();
                IEnumerable<MSI_ComplaintMain> data = (from existingComplaint in uo.Repository<MSI_ComplaintMain>().GetAll().Where(record => record.AgencyId == complaint.AgencyId && record.Account == complaint.Account)
                                                       select existingComplaint);

                if (data.Count() > 0)
                {
                    complaintToSave = data.First();
                }
                else
                {
                    editingRequired = false;
                    complaintToSave = new MSI_ComplaintMain();
                }



                complaintToSave.AgencyId = complaint.AgencyId;
                complaintToSave.Account = complaint.Account;
                complaintToSave.LastName = complaint.LastName;
                complaintToSave.FirstName = complaint.FirstName;
                complaintToSave.Address = complaint.Address;
                complaintToSave.City = complaint.City;
                complaintToSave.State = complaint.State;
                complaintToSave.Zip = complaint.Zip;
                complaintToSave.HomePhone = complaint.HomePhone;
                complaintToSave.WorkPhone = complaint.WorkPhone;
                complaintToSave.MobilePhone = complaint.MobilePhone;
                complaintToSave.LastFourSSN = complaint.LastFourSSN;
                complaintToSave.DebtorIdentityVerifiedYN = complaint.DebtorIdentityVerifiedYN;
                complaintToSave.ContactMethodId = complaint.ContactMethodId;
                complaintToSave.ContactTimeId = complaint.ContactTimeId;
                complaintToSave.CreditorName = complaint.CreditorName;
                complaintToSave.DebtProductId = complaint.DebtProductId;
                complaintToSave.DebtPurchaseBalance = complaint.DebtPurchaseBalance;
                complaintToSave.DebtCurrentBalance = complaint.DebtCurrentBalance;
                complaintToSave.DisputeDebtYN = complaint.DisputeDebtYN;
                complaintToSave.DisputeDebtAmountYN = complaint.DisputeDebtAmountYN;
                complaintToSave.DisputeDebtDueDateYN = complaint.DisputeDebtDueDateYN;
                complaintToSave.ComplaintID = complaint.ComplaintID;
                //complaintToSave.ComplaintDate = complaint.ComplaintDate;
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddHours(DateTime.Now.Hour);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddMinutes(DateTime.Now.Minute);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddSeconds(DateTime.Now.Second);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddMilliseconds(DateTime.Now.Millisecond);
                complaintToSave.ComplaintDate = DateHelper.GetDateWithTimings(complaint.ComplaintDate);
                complaintToSave.ComplaintReceivedByMethodId = complaint.ComplaintReceivedByMethodId;
                complaintToSave.ComplaintIssueId = complaint.ComplaintIssueId;
                complaintToSave.ComplaintNotes = complaint.ComplaintNotes;
                complaintToSave.ComplaintSubmitedToAgencyYN = complaint.ComplaintSubmitedToAgencyYN;
                if(complaint.ComplaintSubmitedToAgencyDate.HasValue)
                    complaintToSave.ComplaintSubmitedToAgencyDate = DateHelper.GetDateWithTimings(complaint.ComplaintSubmitedToAgencyDate.Value);
                complaintToSave.MoreInfoReqdFromDebtorYN = complaint.MoreInfoReqdFromDebtorYN;
                if (complaint.MoreInfoRequestedDate.HasValue)
                    complaintToSave.MoreInfoRequestedDate = DateHelper.GetDateWithTimings(complaint.MoreInfoRequestedDate.Value);
                complaintToSave.MoreInfoRequested = complaint.MoreInfoRequested;
                complaintToSave.MoreInfoReceivedFromDebtorYN = complaint.MoreInfoReceivedFromDebtorYN;
                if( complaint.MoreInfoReceivedDate.HasValue)
                    complaintToSave.MoreInfoReceivedDate = DateHelper.GetDateWithTimings(complaint.MoreInfoReceivedDate.Value);
                complaintToSave.MoreInfoReceived = complaint.MoreInfoReceived;
                complaintToSave.ComplaintSubmittedToOwnerYN = complaint.ComplaintSubmittedToOwnerYN;
                if (complaint.ComplaintSubmittedDate.HasValue)
                    complaintToSave.ComplaintSubmittedDate = DateHelper.GetDateWithTimings(complaint.ComplaintSubmittedDate.Value);
                complaintToSave.TimeToSubmitDays = complaint.TimeToSubmitDays;
                complaintToSave.MoreInfoFromAgencyYN = complaint.MoreInfoFromAgencyYN;
                if (complaint.MoreInfoFromAgencyRequestedDate.HasValue)
                    complaintToSave.MoreInfoFromAgencyRequestedDate = DateHelper.GetDateWithTimings(complaint.MoreInfoFromAgencyRequestedDate.Value);
                complaintToSave.MoreInfoFromAgencyRequested = complaint.MoreInfoFromAgencyRequested;
                complaintToSave.MoreInfoFromAgencyReceived = complaint.MoreInfoFromAgencyReceived;
                complaintToSave.MoreInfoFromAgencyReceivedYN = complaint.MoreInfoFromAgencyReceivedYN;
                if (complaint.MoreInfoFromAgencyReceivedDate.HasValue)
                    complaintToSave.MoreInfoFromAgencyReceivedDate = DateHelper.GetDateWithTimings(complaint.MoreInfoFromAgencyReceivedDate.Value);
                complaintToSave.OwnerResponseId = complaint.OwnerResponseId;
                if(complaint.OwnerResponseDate.HasValue)
                    complaintToSave.OwnerResponseDate = DateHelper.GetDateWithTimings(complaint.OwnerResponseDate.Value);
                complaintToSave.OwnerResponseDays = complaint.OwnerResponseDays;
                if (complaint.AgencyResponseToDebtorDate.HasValue)
                    complaintToSave.AgencyResponseToDebtorDate = DateHelper.GetDateWithTimings(complaint.AgencyResponseToDebtorDate.Value);
                complaintToSave.TotalResponseTimeDays = complaint.TotalResponseTimeDays;
                complaintToSave.DebtorAgreeYN = complaint.DebtorAgreeYN;
                complaintToSave.NeedFurtherActionYN = complaint.NeedFurtherActionYN;
                complaintToSave.FinalActionStepId = complaint.FinalActionStepId;
                if (complaint.ComplaintSubmittedToOwnerYN.Value)
                    complaintToSave.IsViewedByOwner = false;
                complaintToSave.CreatedBy = complaint.CreatedBy;
                complaintToSave.IsViewedByAgency = complaint.IsViewedByAgency;

                if (editingRequired)
                {
                    if(complaintToSave.ComplaintSubmittedDate.HasValue && complaintToSave.ComplaintDate != null)
                        complaintToSave.TimeToSubmitDays = complaintToSave.ComplaintSubmittedDate.Value.Subtract(complaintToSave.ComplaintDate).Days;
                    if (complaintToSave.OwnerResponseDate.HasValue && complaintToSave.ComplaintSubmittedDate.HasValue)
                        complaintToSave.OwnerResponseDays = complaintToSave.OwnerResponseDate.Value.Subtract(complaintToSave.ComplaintSubmittedDate.Value).Days;
                    if (complaintToSave.AgencyResponseToDebtorDate.HasValue && complaintToSave.ComplaintDate != null)
                        complaintToSave.TotalResponseTimeDays = complaintToSave.AgencyResponseToDebtorDate.Value.Subtract(complaintToSave.ComplaintDate).Days;
                    //repository.Update(complaintToSave);
                    uo.Repository<MSI_ComplaintMain>().Update(complaintToSave);
                    uo.Save();
                }
                else
                {
                    //complaintToSave.ComplaintSubmitedToAgency = true;
                    //complaintToSave.ComplaintSubmitedToAgencyDate = DateTime.Now;
                    //repository.Add(complaintToSave);
                    uo.Repository<MSI_ComplaintMain>().Add(complaintToSave);
                    uo.Save();
                }
                
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException validationException)
            {
                foreach (System.Data.Entity.Validation.DbEntityValidationResult errorResult in validationException.EntityValidationErrors)
                {
                    foreach (System.Data.Entity.Validation.DbValidationError error in errorResult.ValidationErrors)
                    {
                        string data = error.ErrorMessage;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return complaintToSave;
        }

        private void PopulateComplaintID(MSI_ComplaintMain complaint)
        {
            if (string.IsNullOrEmpty(complaint.ComplaintID))
            {
                Random rnd = new Random();

                complaint.ComplaintID = complaint.AgencyId + "-" + complaint.Account.Substring(5, 10) + "-" + rnd.Next(101, 999).ToString();
            }
        }
    }
}
