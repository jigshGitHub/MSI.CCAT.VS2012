﻿using System;
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
    public class AccountsController : ApiController
    {
        public AccountsController()
        {
        }

        public IEnumerable<Tbl_Account> Get(string userRole, string roleEntityValue = "", string firstOrLastName = "", string accountNumber = "", string creditorName = "", string accountOriginal = "")
        {
            IEnumerable<Tbl_Account> accounts = null;

            try
            {
                DataQueries query = new DataQueries();
                accounts = query.GetAccounts(firstOrLastName, accountNumber, creditorName, accountOriginal, roleEntityValue, (UserRole) Enum.Parse(typeof(UserRole),userRole));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return accounts;
        }
        public Tbl_Account Post(Tbl_Account account)
        {
            UnitOfWork uo = null;
            Tbl_Account accountToSave = null;
            try
            {
                uo = new UnitOfWork("CCATDBEntities");
                accountToSave = uo.AccountRepository.GetById(account.AccountNumber);
                if (accountToSave != null)
                {
                    accountToSave.Address = account.Address;
                    accountToSave.Address2 = account.Address2;
                    accountToSave.City = account.City;
                    accountToSave.DebtCurrentBalance = account.DebtCurrentBalance;
                    accountToSave.DebtPurchaseBalance = account.DebtPurchaseBalance;
                    accountToSave.FirstName = account.FirstName;
                    accountToSave.HomePhone = account.HomePhone;
                    accountToSave.LastFourSSN = account.LastFourSSN;
                    accountToSave.LastName = account.LastName;
                    accountToSave.MobilePhone = account.MobilePhone;
                    accountToSave.StateId = account.StateId;
                    accountToSave.WorkPhone = account.WorkPhone;
                    accountToSave.Zip = account.Zip;
                
                    uo.Repository<Tbl_Account>().Update(accountToSave);
                    uo.Save();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return account;
        }
    }
    public class ComplianceController : ApiController
    {
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

        public Tbl_ComplaintMain Get(string accountNumber, string userAgency = "", string userRole = "", string createUpdateMode = "")
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
                    if(createUpdateMode == "create")
                        throw new Exception(string.Format("Complaint with account number {0} has already been under process",complaint.AccountNumber));
                    if (!string.IsNullOrEmpty(userRole))
                    {
                        if (userRole == UserRole.DebtOwner.ToString())
                        {
                            complaint.IsViewedByOwner = true;
                            if (complaint.ComplaintStatusId == (int)ComplaintStatus.SFOA)
                                complaint.ComplaintStatusId = (int)ComplaintStatus.ORIP;
                        }
                        if (userRole == UserRole.CollectionAgency.ToString())
                            complaint.IsViewedByAgency = true;
                        uo.Repository<Tbl_ComplaintMain>().Update(complaint);
                        uo.Save();
                    }
                }
                else
                {
                    complaint = new Tbl_ComplaintMain();
                    complaint.AccountNumber = accountNumber;
                    complaint.IssuesId = 29;//default
                    complaint.ComplaintDate = DateTime.Now;
                }
                //complaint.Tbl_Account = uo.Repository<Tbl_Account>().GetAll().Where(account => account.AccountNumber == accountNumber).Single();
                complaint.Tbl_Account = uo.AccountRepository.GetAccounts( accountNumber).Single();
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
            UserRole role;
            try
            {

                role = MSI.CCAT.Business.AccountBus.GetUserRole(complaint.CreatedBy.ToString());
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

                //complaint.Tbl_Account = uo.Repository<Tbl_Account>().GetAll().Where(account => account.AccountNumber == complaint.AccountNumber).Single();
                complaint.Tbl_Account = uo.AccountRepository.GetAccounts(complaint.AccountNumber).Single();
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
                if (complaint.ComplaintSubmittedToOwnerYN.Value)
                    complaintToSave.IsViewedByOwner = false;
                complaintToSave.CreatedBy = complaint.CreatedBy;
                complaintToSave.IsViewedByAgency = complaint.IsViewedByAgency;
                complaintToSave.IsActive = true;
                complaintToSave.ComplaintStatusId = (int)GetComplaintStatus(role, complaint.AccountNumber, complaintToSave);
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
                    complaintToSave.UpdatedBy = complaint.UpdatedBy;
                    complaintToSave.UpdatedDateTime = DateTime.Now;
                }
                else
                {
                    //complaintToSave.ComplaintSubmitedToAgency = true;
                    //complaintToSave.ComplaintSubmittedToAgencyDate = DateTime.Now;
                    //repository.Add(complaintToSave);
                    complaintToSave.CreatedBy = complaint.CreatedBy;
                    complaintToSave.UpdatedBy = complaint.UpdatedBy;
                    complaintToSave.CreatedDateTime = DateTime.Now;
                    complaintToSave.UpdatedDateTime = DateTime.Now;
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

        private ComplaintStatus GetComplaintStatus(UserRole userRole, string accountNumber, Tbl_ComplaintMain complaintToAnalize)
        {
            UnitOfWork uo;
            ComplaintStatus complaintStatus = ComplaintStatus.BLANK;;
            try
            {
                uo = new UnitOfWork("CCATDBEntities");
                if (userRole == UserRole.CollectionAgency)
                {
                    return CollectionAgencyGetComplaintStatus(uo.Repository<Tbl_ComplaintMain>().GetAll().Where(r=>r.AccountNumber == accountNumber).SingleOrDefault(), complaintToAnalize);
                }
                if (userRole == UserRole.DebtOwner)
                {
                    return DebtOwnerGetComplaintStatus(uo.Repository<Tbl_ComplaintMain>().GetAll().Where(r => r.AccountNumber == accountNumber).SingleOrDefault(), complaintToAnalize);
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }
            return complaintStatus;
        }
        private ComplaintStatus CollectionAgencyGetComplaintStatus(Tbl_ComplaintMain presentComplaint, Tbl_ComplaintMain complaintToAnalize)
        {
            ComplaintStatus complaintStatus = ComplaintStatus.BLANK;
            try
            {
                #region NCRA
                if (presentComplaint == null)
                {
                    return complaintStatus = (complaintToAnalize.DebtorIdentityVerifiedYN.Value) ? ComplaintStatus.NCIP:ComplaintStatus.NCRA;
                }
                #endregion

                complaintStatus = (ComplaintStatus)presentComplaint.ComplaintStatusId;

                #region NCIP

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCRA
                    && complaintToAnalize.DebtorIdentityVerifiedYN.Value == true
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == false
                    && complaintToAnalize.MoreInfoRequestedDate.HasValue == false)
                    complaintStatus = ComplaintStatus.NCIP;
                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.AAI
                    && complaintToAnalize.MoreInfoReceivedFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoReceivedDate.HasValue == true
                    && complaintToAnalize.MoreInfoFromAgencyReceivedYN.Value == false
                    && complaintToAnalize.MoreInfoFromAgencyReceivedDate.HasValue == false
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == false
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == false)
                    complaintStatus = ComplaintStatus.NCIP;
                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.AAI
                    && complaintToAnalize.MoreInfoFromAgencyReceivedYN.Value == true
                    && complaintToAnalize.MoreInfoFromAgencyReceivedDate.HasValue == true
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == false
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == false)
                    complaintStatus = ComplaintStatus.NCIP;                

                #endregion

                #region AAI

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCRA
                    && complaintToAnalize.DebtorIdentityVerifiedYN.Value == true
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoRequestedDate.HasValue == true
                    && !string.IsNullOrEmpty(complaintToAnalize.MoreInfoRequested))
                    complaintStatus = ComplaintStatus.AAI;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCIP
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoRequestedDate.HasValue == true
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoRequested)
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == false
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == false))
                    complaintStatus = ComplaintStatus.AAI;

                #endregion

                #region SFOA

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCIP
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == true
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == true
                    && complaintToAnalize.DebtorAgreeYN.Value == false
                    && complaintToAnalize.FinalActionStepId.HasValue == false)
                    complaintStatus = ComplaintStatus.SFOA;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.AAI
                    && complaintToAnalize.MoreInfoReceivedFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoReceivedDate.HasValue == true
                    && complaintToAnalize.MoreInfoFromAgencyReceivedYN.Value == false
                    && complaintToAnalize.MoreInfoFromAgencyReceivedDate.HasValue == false
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == true
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == true)
                    complaintStatus = ComplaintStatus.SFOA;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.AAI
                    && complaintToAnalize.MoreInfoFromAgencyReceivedYN.Value == true
                    && complaintToAnalize.MoreInfoFromAgencyReceivedDate.HasValue == true
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == true
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == true)
                    complaintStatus = ComplaintStatus.SFOA;

                #endregion

                #region RC

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCIP
                    && complaintToAnalize.DebtorAgreeYN.Value == true
                    && complaintToAnalize.FinalActionStepId.HasValue == true)
                    complaintStatus = ComplaintStatus.RC;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCIP
                    && complaintToAnalize.DebtorAgreeYN.Value == false 
                    && complaintToAnalize.NeedFurtherActionYN.Value == true
                    && complaintToAnalize.FinalActionStepId.HasValue == true)
                    complaintStatus = ComplaintStatus.RC;

                #endregion
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return complaintStatus;

        }
        private ComplaintStatus DebtOwnerGetComplaintStatus(Tbl_ComplaintMain presentComplaint, Tbl_ComplaintMain complaintToAnalize)
        {
            ComplaintStatus complaintStatus = ComplaintStatus.BLANK;
            try
            {
                #region NCRA
                if (presentComplaint == null)
                {
                    return complaintStatus = (complaintToAnalize.DebtorIdentityVerifiedYN.Value) ? ComplaintStatus.ORIP : ComplaintStatus.NCRA;
                }
                #endregion

                complaintStatus = (ComplaintStatus)presentComplaint.ComplaintStatusId;

                #region NCIP

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.ORIP
                    && complaintToAnalize.OwnerResponseId.HasValue == true
                    && complaintToAnalize.OwnerResponseDate.HasValue == true)
                    complaintStatus = ComplaintStatus.NCIP;

                #endregion

                #region AAI

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.ORIP
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoRequestedDate.HasValue == true
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoRequested))
                    && complaintToAnalize.MoreInfoFromAgencyYN.Value == false
                    && complaintToAnalize.MoreInfoFromAgencyRequestedDate.HasValue == false
                    && complaintToAnalize.OwnerResponseId.HasValue == false
                    && complaintToAnalize.OwnerResponseDate.HasValue == false)
                    complaintStatus = ComplaintStatus.AAI;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.ORIP
                    && complaintToAnalize.MoreInfoFromAgencyYN.Value == true
                    && complaintToAnalize.MoreInfoFromAgencyRequestedDate.HasValue == true
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoFromAgencyRequested))
                    && complaintToAnalize.OwnerResponseId.HasValue == false
                    && complaintToAnalize.OwnerResponseDate.HasValue == false)
                    complaintStatus = ComplaintStatus.AAI;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.ORIP
                    && presentComplaint.MoreInfoReqdFromDebtorYN.Value == true
                    && presentComplaint.MoreInfoRequestedDate.HasValue == true
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == true
                    && presentComplaint.MoreInfoRequested.Length <= complaintToAnalize.MoreInfoRequested.Length
                    && complaintToAnalize.OwnerResponseId.HasValue == false
                    && complaintToAnalize.OwnerResponseDate.HasValue == false)
                    complaintStatus = ComplaintStatus.AAI;

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.ORIP
                    && presentComplaint.MoreInfoReqdFromDebtorYN.Value == false
                    && presentComplaint.MoreInfoRequestedDate.HasValue == false
                    && complaintToAnalize.MoreInfoReqdFromDebtorYN.Value == true
                    && complaintToAnalize.MoreInfoRequestedDate.HasValue == true 
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoRequested))
                    && complaintToAnalize.OwnerResponseId.HasValue == false
                    && complaintToAnalize.OwnerResponseDate.HasValue == false)
                    complaintStatus = ComplaintStatus.AAI;

                #endregion

                #region ORIP

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.AAI
                    && complaintToAnalize.MoreInfoFromAgencyYN.Value == true
                    && complaintToAnalize.MoreInfoFromAgencyRequestedDate.HasValue == true
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoFromAgencyRequested))
                    && complaintToAnalize.MoreInfoFromAgencyReceivedYN.Value == true
                    && complaintToAnalize.MoreInfoFromAgencyReceivedDate.HasValue == true
                    && (!string.IsNullOrEmpty(complaintToAnalize.MoreInfoFromAgencyReceived)))
                    complaintStatus = ComplaintStatus.ORIP;

                #endregion
                #region SFOA

                if (presentComplaint.ComplaintStatusId == (int)ComplaintStatus.NCIP
                    && complaintToAnalize.ComplaintSubmittedToOwnerYN.Value == true
                    && complaintToAnalize.ComplaintSubmittedDate.HasValue == true)
                    complaintStatus = ComplaintStatus.SFOA;

                #endregion
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return complaintStatus;

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
