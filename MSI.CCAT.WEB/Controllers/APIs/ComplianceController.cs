using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Cascade.Data.Models;
using MSI.CCAT.Data.Models;
using Cascade.Data.Repositories;
using MSI.CCAT.Data.Repositories;
//using Cascade.Helpers;
namespace Cascade.Web.Controllers
{
    //public class DebtorsController : ApiController
    //{
    //    public IEnumerable<MSI_Debtor> Get(string accountNumber)
    //    {
    //        IEnumerable<MSI_Debtor> debtors = null;

    //        try
    //        {
    //            DataQueries query = new DataQueries();
    //            debtors = query.GetDebtors(accountNumber);
    //        }
    //        catch (Exception ex)
    //        {
    //        }
    //        return debtors;
    //    }
    //}
    public class AccountsController : ApiController
    {
        public IEnumerable<Tbl_Account> Get(string userAgency = "",string firstOrLastName="", string accountNumber="", string creditorName="", string accountOriginal="")
        {
            IEnumerable<Tbl_Account> accounts = null;

            try
            {
                DataQueries query = new DataQueries();
                accounts = query.GetAccounts(firstOrLastName, accountNumber,  creditorName, accountOriginal, userAgency);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return accounts;
        }
    }
    public class ComplianceController : ApiController
    {
        //private void PopulateDebtInfo(MSI_Debtor debtor, MSI_ComplaintMain complaint)
        //{
        //    complaint.Account = debtor.Account;
        //    complaint.FirstName = debtor.FirstName;
        //    complaint.LastName = debtor.LastName;
        //    complaint.Address = debtor.Address1 + " " + debtor.Address2;
        //    complaint.City = debtor.City;
        //    complaint.State = debtor.State;
        //    complaint.Zip = debtor.Zip;
        //    complaint.LastFourSSN = debtor.LastFourSSN;
        //    complaint.MobilePhone = debtor.MobilePhone;
        //    complaint.HomePhone = debtor.HomePhone;
        //    complaint.WorkPhone = debtor.WorkPhone;
        //    complaint.DebtCurrentBalance = debtor.DebtCurrentBalance;
        //    complaint.DebtPurchaseBalance = debtor.DebtPurchaseBalance;
        //    complaint.CreditorName = debtor.CreditorName;
        //}
        private void PopulateDebtInfo(Tbl_Account account, Tbl_ComplaintMain complaint)
        {
            complaint.Tbl_Account.AccountNumber = account.AccountNumber;
            complaint.Tbl_Account.FirstName = account.FirstName;
            complaint.Tbl_Account.LastName = account.LastName;
            complaint.Tbl_Account.Address = account.Address;
            complaint.Tbl_Account.City = account.City;
            complaint.Tbl_Account.StateId = account.StateId;
            complaint.Tbl_Account.Zip = account.Zip;
            complaint.Tbl_Account.LastFourSSN = account.LastFourSSN;
            complaint.Tbl_Account.MobilePhone = account.MobilePhone;
            complaint.Tbl_Account.HomePhone = account.HomePhone;
            complaint.Tbl_Account.WorkPhone = account.WorkPhone;
            complaint.Tbl_Account.DebtCurrentBalance = account.DebtCurrentBalance;
            complaint.Tbl_Account.DebtPurchaseBalance = account.DebtPurchaseBalance;
            complaint.Tbl_Account.CreditorName = account.CreditorName;
        }

        public Tbl_ComplaintMain Get(string accountNumber, string userAgency = "", string userRole = "")
        {
            //MSI_ComplaintMainRepository repository = null;
            UnitOfWork uo = null;
            Tbl_ComplaintMain complaint = null; ;
            try
            {
                //repository = new MSI_ComplaintMainRepository();
                uo = new UnitOfWork("CCATDBEntities");

                complaint = uo.Repository<Tbl_ComplaintMain>().GetAll().Where(record => record.AccountNumber == accountNumber).FirstOrDefault();
                        
                if (complaint != null)
                {
                    if (!string.IsNullOrEmpty(userRole))
                    {
                        if (userRole == UserRoles.DebtOwner.ToString())
                            complaint.IsViewedByOwner = true;
                        if (userRole == UserRoles.CollectionAgency.ToString())
                            complaint.IsViewedByAgency = true;
                        uo.Repository<Tbl_ComplaintMain>().Update(complaint);
                        uo.Save();
                    }
                }
                else
                {
                    complaint = new Tbl_ComplaintMain();
                    complaint.AccountNumber = accountNumber;
                    complaint.ComplaintDate = DateTime.Now;
                }
                complaint.Tbl_Account = uo.Repository<Tbl_Account>().GetAll().Where(account => account.AccountNumber == accountNumber).Single();
                complaint.Tbl_Account.Tbl_Agency = uo.Repository<Tbl_Agency>().GetById(complaint.Tbl_Account.AgencyId.Value);
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException validationException)
            {
                foreach (System.Data.Entity.Validation.DbEntityValidationResult errorResult in validationException.EntityValidationErrors)
                {
                    foreach (System.Data.Entity.Validation.DbValidationError error in errorResult.ValidationErrors)
                    {
                        string data = error.ErrorMessage;
                        throw new Exception(data);
                    }
                }
            }
            catch (Exception ex)    
            {
                throw ex;
            }
            return complaint;
        }

        public Tbl_ComplaintMain Post(Tbl_ComplaintMain complaint)
        {
            Tbl_ComplaintMain complaintToSave = null;
            UnitOfWork uo = null;
            bool editingRequired = true;
            try
            {
                uo = new UnitOfWork("CCATDBEntities");
                IEnumerable<Tbl_ComplaintMain> data = (from existingComplaint in uo.Repository<Tbl_ComplaintMain>().GetAll().Where(record => record.AccountNumber == complaint.AccountNumber)
                                                       select existingComplaint);

                if (data.Count() > 0)
                {
                    complaintToSave = data.First();
                }
                else
                {
                    editingRequired = false;
                    complaintToSave = new Tbl_ComplaintMain();
                }

                complaint.Tbl_Account = uo.Repository<Tbl_Account>().GetAll().Where(account => account.AccountNumber == complaint.AccountNumber).Single();
                complaint.Tbl_Account.Tbl_Agency = uo.Repository<Tbl_Agency>().GetById(complaint.Tbl_Account.AgencyId.Value);
                complaintToSave.AccountNumber = complaint.AccountNumber;
                complaintToSave.DebtorIdentityVerifiedYN = complaint.DebtorIdentityVerifiedYN;
                complaintToSave.DebtorContactMethodId = complaint.DebtorContactMethodId;
                complaintToSave.DebtorContactTimeId = complaint.DebtorContactTimeId;
                //complaintToSave.CreditorName = complaint.CreditorName;
                complaintToSave.DebtorProductId = complaint.DebtorProductId;
                complaintToSave.DisputeDebtYN = complaint.DisputeDebtYN;
                complaintToSave.DisputeDebtAmountYN = complaint.DisputeDebtAmountYN;
                complaintToSave.DisputeDebtDueDateYN = complaint.DisputeDebtDueDateYN;
                complaintToSave.ComplaintId = complaint.ComplaintId;
                //complaintToSave.ComplaintDate = complaint.ComplaintDate;
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddHours(DateTime.Now.Hour);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddMinutes(DateTime.Now.Minute);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddSeconds(DateTime.Now.Second);
                //complaintToSave.ComplaintDate = complaintToSave.ComplaintDate.AddMilliseconds(DateTime.Now.Millisecond);
                complaintToSave.ComplaintDate = DateHelper.GetDateWithTimings(complaint.ComplaintDate);
                complaintToSave.ReceivedByMethodId = complaint.ReceivedByMethodId;
                complaintToSave.IssuesId = complaint.IssuesId;
                complaintToSave.ComplaintNotes = complaint.ComplaintNotes;
                complaintToSave.ComplaintSubmittedToAgencyYN = complaint.ComplaintSubmittedToAgencyYN;
                if(complaint.ComplaintSubmittedToAgencyDate.HasValue)
                    complaintToSave.ComplaintSubmittedToAgencyDate = DateHelper.GetDateWithTimings(complaint.ComplaintSubmittedToAgencyDate.Value);
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
                //if (complaint.ComplaintSubmittedToOwnerYN.Value)
                //    complaintToSave.IsViewedByOwner = false;
                //complaintToSave.CreatedBy = complaint.CreatedBy;
                //complaintToSave.IsViewedByAgency = complaint.IsViewedByAgency;

                
                if (editingRequired)
                {
                    if(complaintToSave.ComplaintSubmittedDate.HasValue && complaintToSave.ComplaintDate != null)
                        complaintToSave.TimeToSubmitDays = complaintToSave.ComplaintSubmittedDate.Value.Subtract(complaintToSave.ComplaintDate.Value).Days;
                    if (complaintToSave.OwnerResponseDate.HasValue && complaintToSave.ComplaintSubmittedDate.HasValue)
                        complaintToSave.OwnerResponseDays = complaintToSave.OwnerResponseDate.Value.Subtract(complaintToSave.ComplaintSubmittedDate.Value).Days;
                    if (complaintToSave.AgencyResponseToDebtorDate.HasValue && complaintToSave.ComplaintDate != null)
                        complaintToSave.TotalResponseTimeDays = complaintToSave.AgencyResponseToDebtorDate.Value.Subtract(complaintToSave.ComplaintDate.Value).Days;
                    //repository.Update(complaintToSave);
                    uo.Repository<Tbl_ComplaintMain>().Update(complaintToSave);
                    uo.Save();
                }
                else
                {
                    //complaintToSave.ComplaintSubmitedToAgency = true;
                    //complaintToSave.ComplaintSubmittedToAgencyDate = DateTime.Now;
                    //repository.Add(complaintToSave);
                    uo.Repository<Tbl_ComplaintMain>().Add(complaintToSave);
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

        private void PopulateComplaintID(Tbl_ComplaintMain complaint)
        {
            if (string.IsNullOrEmpty(complaint.ComplaintId.ToString()))
            {
                Random rnd = new Random();

                complaint.ComplaintId = complaint.Tbl_Account.AgencyId + "-" + complaint.AccountNumber.Substring(5, 10) + "-" + rnd.Next(101, 999).ToString();
            }
        }
    }
    public class DateHelper
    {
        public static DateTime? GetDateWithTimings(DateTime? dt)
        {
            if (dt.HasValue)
            {
                dt = dt.Value.AddHours(DateTime.Now.Hour);
                dt = dt.Value.AddMinutes(DateTime.Now.Minute);
                dt = dt.Value.AddSeconds(DateTime.Now.Second);
                dt = dt.Value.AddMilliseconds(DateTime.Now.Millisecond);
            }
            return dt;
        }
    }
}
