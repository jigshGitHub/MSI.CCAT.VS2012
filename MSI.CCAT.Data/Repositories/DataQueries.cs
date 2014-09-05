using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Cascade.Data.Models;
using System.Data.SqlClient;
using System.Data;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;
namespace Cascade.Data.Repositories
{
    public class DataQueries
    {
        private static readonly string thisClass = "Cascade.Data.Repositories.DataQueries";

        public IEnumerable<MSI_Debtor> GetDebtors(string accountNumber)
        {
            string thisMethod = string.Format("{0}.{1}", thisClass, System.Reflection.MethodBase.GetCurrentMethod().Name);
            string logMessage = string.Format("{0}|Method incoming parameters accountNumber={1}", thisMethod, accountNumber);
            //LogHelper.Info(logMessage);

            MSI_Debtor debtor = null;
            DBFactory db;
            List<MSI_Debtor> debtors = null;
            System.Data.DataSet ds;
            try
            {
                db = new DBFactory("CascadeDBEntities");
                ds = db.ExecuteDataset("MSI_spGetDebtors", "Debtors", new SqlParameter("@pimsAccountNumber", accountNumber));

                if (ds.Tables["Debtors"].Rows.Count > 0)
                {
                    debtors = new List<MSI_Debtor>();
                    foreach (System.Data.DataRow dr in ds.Tables["Debtors"].Rows)
                    {
                        debtor = new MSI_Debtor();
                        debtor.Account = dr["ACCOUNT"].ToString();
                        debtor.FirstName = dr["FirstName"].ToString();
                        debtor.LastName = dr["LastName"].ToString();
                        debtor.Address1 = dr["ADDRESS1"].ToString();
                        debtor.Address2 = dr["ADDRESS2"].ToString();
                        debtor.City = dr["CITY"].ToString();
                        debtor.State = dr["STATE"].ToString();
                        debtor.Zip = dr["ZIP_CODE"].ToString();
                        string ssn = dr["SSN"].ToString().Trim();
                        debtor.LastFourSSN = ssn.Substring(7, 4);
                        debtor.MobilePhone = dr["PHONE_CELL"].ToString();
                        debtor.HomePhone = dr["PHONE_HOME"].ToString();
                        debtor.WorkPhone = dr["PHONE_WORK"].ToString();
                        debtor.DOB = dr["DOB"].ToString();
                        debtor.DebtCurrentBalance = dr["DebtCurrentBalance"].ToString();
                        debtor.DebtPurchaseBalance = dr["DebtorPurchaseBalance"].ToString();
                        debtor.CreditorName = dr["CreditorName"].ToString();

                        debtors.Add(debtor);
                    }
                }

            }
            catch (Exception ex)
            {
                //ErrorLogHelper.Error(logMessage, ex);
                throw ex;
            }
            return debtors.AsEnumerable<MSI_Debtor>();
        }

        public IEnumerable<Tbl_Account> GetAccounts(string firstOrLastName, string accountNumber, string creditorName, string accountOriginal, string roleEntityValue, UserRole role)
        {
            IEnumerable<Tbl_Account> accounts = null;
            try
            {
                IUnitOfWork uow = new UnitOfWork("CCATDBEntities");
                //accounts = uow.Repository<Tbl_Account>().GetAll();
                accounts = (uow as UnitOfWork).AccountRepository.GetAccounts();
                if (role == UserRole.CollectionAgency)
                {
                    if (!string.IsNullOrEmpty(roleEntityValue))
                    {
                        int agencyId = uow.Repository<Tbl_Agency>().GetAll().Where(a => a.Name == roleEntityValue).SingleOrDefault().AgencyId;
                        //accounts = accounts.Where(a => a.AgencyId == agencyId);
                        accounts = (uow as UnitOfWork).AccountRepository.GetAccounts(agencyId);
                    }
                }
                else if (role == UserRole.DebtOwner)
                {
                    if (!string.IsNullOrEmpty(roleEntityValue))
                    {
                        accounts = accounts.Where(a => a.OwnerId == int.Parse(roleEntityValue));
                    }
                }
                if (!string.IsNullOrEmpty(firstOrLastName))
                    return accounts.Where(record => record.FirstName.ToLower().Contains(firstOrLastName.ToLower()) || record.LastName.ToLower().Contains(firstOrLastName.ToLower()));
                if (!string.IsNullOrEmpty(accountNumber))
                    return accounts.Where(record => record.AccountNumber.ToLower().Contains(accountNumber.ToLower()));
                if (!string.IsNullOrEmpty(creditorName))
                    return accounts.Where(record => record.CreditorName.ToLower().Contains(creditorName.ToLower()));
                if (!string.IsNullOrEmpty(accountOriginal))
                    return accounts.Where(record => record.AccountOriginal.ToLower().Contains(accountOriginal.ToLower()));

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return accounts;
        }
        //public IEnumerable<ComplianceViewResult> GetComplianceReportRecords(string AgencyId, string reportType)
        //{
        //    string thisMethod = string.Format("{0}.{1}", thisClass, System.Reflection.MethodBase.GetCurrentMethod().Name);
        //    string logMessage = string.Format("{0}|Method incoming parameters AgencyId={1}, reportType={2}", thisMethod, AgencyId, reportType);
        //    //LogHelper.Info(logMessage);

        //    DBFactory db;
        //    SqlDataReader rdr = null;
        //    string reportName = "";
        //    List<ComplianceViewResult> data = null;
        //    try
        //    {

        //        db = new DBFactory("CascadeDBEntities");
        //        switch (reportType)
        //        {
        //            case "NCRA": reportName = "MSI_spGetComplianceNCRAReportData";
        //                break;
        //            case "ORP": reportName = "MSI_spGetComplianceORPReportData";
        //                break;
        //            case "RC": reportName = "MSI_spGetComplianceRCReportData";
        //                break;
        //            case "SOA": reportName = "MSI_spGetComplianceSOAReportData";
        //                break;
        //            case "AAI": reportName = "MSI_spGetComplianceAAIReportData";
        //                break;
        //            case "NCP": reportName = "MSI_spGetComplianceNCPReportData";
        //                break;

        //        }


        //        rdr = db.ExecuteReader(reportName, new SqlParameter("@AgencyId", AgencyId));
        //        data = new List<ComplianceViewResult>();
        //        ComplianceViewResult record;
        //        while (rdr.Read())
        //        {
        //            record = new ComplianceViewResult();
        //            record.AgencyId = rdr["AgencyId"].ToString();
        //            record.ComplaintID = rdr["ComPlaintId"].ToString();
        //            record.Account = rdr["PIMSAccount"].ToString();
        //            record.LastName = rdr["LastName"].ToString();
        //            record.FirstName = rdr["FirstName"].ToString();
        //            record.LastFourSSN = rdr["LastFourSSN"].ToString();
        //            if (rdr["ComplaintDate"] != DBNull.Value)
        //                record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
        //            if (rdr["MoreInfoRequestedDate"] != DBNull.Value)
        //                record.MoreInfoRequestedDate = Convert.ToDateTime(rdr["MoreInfoRequestedDate"]);
        //            if (rdr["ComplaintSubmittedDate"] != DBNull.Value)
        //                record.ComplaintSubmittedDate = Convert.ToDateTime(rdr["ComplaintSubmittedDate"]);
        //            if (rdr["AgencyResponseToDebtorDate"] != DBNull.Value)
        //                record.AgencyResponseToDebtorDate = Convert.ToDateTime(rdr["AgencyResponseToDebtorDate"]);
        //            if (rdr["TotalResponseTimeDays"] != DBNull.Value)
        //                record.TotalResponseTimeDays = rdr["TotalResponseTimeDays"].ToString();

        //            if (record.ComplaintDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintDate = null;
        //            }
        //            if (record.MoreInfoRequestedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.MoreInfoRequestedDate = null;
        //            }
        //            if (record.ComplaintSubmittedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintSubmittedDate = null;
        //            }
        //            if (record.AgencyResponseToDebtorDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.AgencyResponseToDebtorDate = null;
        //            }


        //            data.Add(record);
        //        }
        //        //Close the datareader
        //        rdr.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        //ErrorLogHelper.Error(logMessage, ex);
        //        throw new Exception("Exception in DataQueries.ReportType:" + reportType + "GetComplianceReportRecords:" + ex.Message);
        //    }
        //    return data.AsEnumerable<ComplianceViewResult>();
        //}
        //public IEnumerable<ComplianceViewResult> GetComplianceReportRecordsExport(string AgencyId, string reportType)
        //{
        //    string thisMethod = string.Format("{0}.{1}", thisClass, System.Reflection.MethodBase.GetCurrentMethod().Name);
        //    string logMessage = string.Format("{0}|Method incoming parameters AgencyId={1}, reportType={2}", thisMethod, AgencyId, reportType);
        //    //LogHelper.Info(logMessage);

        //    DBFactory db;
        //    SqlDataReader rdr;
        //    List<ComplianceViewResult> data = null;
        //    string reportName = "";
        //    try
        //    {
        //        db = new DBFactory("CascadeDBEntities");
        //        switch (reportType)
        //        {
        //            case "NCRA": reportName = "MSI_spGetComplianceNCRAReportDataExport";
        //                break;
        //            case "ORP": reportName = "MSI_spGetComplianceORPReportDataExport";
        //                break;
        //            case "RC": reportName = "MSI_spGetComplianceRCReportDataExport";
        //                break;
        //            case "SOA": reportName = "MSI_spGetComplianceSOAReportDataExport";
        //                break;
        //            case "AAI": reportName = "MSI_spGetComplianceAAIReportDataExport";
        //                break;
        //            case "NCP": reportName = "MSI_spGetComplianceNCPReportDataExport";
        //                break;

        //        }
        //        //rdr = db.ExecuteReader("MSI_spGetComplianceNCRAReportDataExport", new SqlParameter("@AgencyId", AgencyId));
        //        rdr = db.ExecuteReader(reportName, new SqlParameter("@AgencyId", AgencyId));
        //        data = new List<ComplianceViewResult>();
        //        ComplianceViewResult record;
        //        while (rdr.Read())
        //        {
        //            record = new ComplianceViewResult();
        //            record.AgencyId = rdr["AgencyId"].ToString();
        //            record.AgencyName = rdr["AgencyName"].ToString();
        //            record.LastName = rdr["LastName"].ToString();
        //            record.FirstName = rdr["FirstName"].ToString();
        //            record.Account = rdr["PIMSAccount"].ToString();
        //            record.ComplaintID = rdr["ComPlaintId"].ToString();
        //            record.HomePhone = rdr["HomePhone"].ToString();
        //            record.WorkPhone = rdr["WorkPhone"].ToString();
        //            record.LastFourSSN = rdr["LastFourSSN"].ToString();
        //            record.MobilePhone = rdr["MobilePhone"].ToString();
        //            record.Address = rdr["Address"].ToString();
        //            record.City = rdr["City"].ToString();
        //            record.State = rdr["State"].ToString();
        //            record.Zip = rdr["Zip"].ToString();
        //            record.CreditorName = rdr["CreditorName"].ToString();
        //            record.DebtorIdentityVerified = rdr["DebtorIdentityVerifiedText"].ToString();
        //            record.ContactMethod = rdr["ContactMethod"].ToString();
        //            record.ContactTime = rdr["ContactTime"].ToString();
        //            record.DebtProduct = rdr["DebtProduct"].ToString();
        //            if (rdr["DebtPurchaseBalance"].ToString() != "")
        //                record.DebtPurchaseBalance = rdr["DebtPurchaseBalance"] == DBNull.Value ? Convert.ToDecimal(0.0) : Convert.ToDecimal(rdr["DebtPurchaseBalance"]);
        //            if (rdr["DebtCurrentBalance"].ToString() != "")
        //                record.DebtCurrentBalance = rdr["DebtCurrentBalance"] == DBNull.Value ? Convert.ToDecimal(0.0) : Convert.ToDecimal(rdr["DebtCurrentBalance"]);
        //            record.DisputeDebt = rdr["DisputeDebtText"].ToString();
        //            record.DisputeDebtAmount = rdr["DisputeDebtAmountText"].ToString();
        //            record.DisputeDebtDueDate = rdr["DisputeDebtDueDateText"].ToString();

        //            record.ComplaintID = rdr["ComplaintId"].ToString();
        //            if (rdr["ComplaintDate"] != DBNull.Value)
        //                record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
        //            record.ComplaintReceivedByMethod = rdr["ComplaintReceivedByMethod"].ToString();
        //            record.ComplaintIssue = rdr["ComplaintIssue"].ToString();
        //            record.ComplaintNotes = rdr["ComplaintNotes"].ToString();
        //            record.ComplaintSubmitedToAgency = rdr["ComplaintSubmitedToAgencyText"].ToString();
        //            if (rdr["ComplaintSubmitedToAgencyDate"] != DBNull.Value)
        //                record.ComplaintSubmitedToAgencyDate = Convert.ToDateTime(rdr["ComplaintSubmitedToAgencyDate"]);
        //            record.MoreInfoReqdFromDebtor = rdr["MoreInfoReqdFromDebtorText"].ToString();
        //            if (rdr["MoreInfoRequestedDate"] != DBNull.Value)
        //                record.MoreInfoRequestedDate = Convert.ToDateTime(rdr["MoreInfoRequestedDate"]);
        //            record.MoreInfoRequested = rdr["MoreInfoRequested"].ToString();
        //            record.MoreInfoReceivedFromDebtor = rdr["MoreInfoReceivedFromDebtorText"].ToString();
        //            if (rdr["MoreInfoReceivedDate"] != DBNull.Value)
        //                record.MoreInfoReceivedDate = Convert.ToDateTime(rdr["MoreInfoReceivedDate"]);
        //            record.MoreInfoReceived = rdr["MoreInfoReceived"].ToString();
        //            record.ComplaintSubmittedToOwner = rdr["ComplaintSubmittedToOwnerText"].ToString();
        //            if (rdr["ComplaintSubmittedDate"] != DBNull.Value)
        //                record.ComplaintSubmittedDate = Convert.ToDateTime(rdr["ComplaintSubmittedDate"]);
        //            record.TimeToSubmitDays = rdr["TimeToSubmitDays"].ToString();
        //            record.MoreInfoFromAgency = rdr["MoreInfoFromAgencyText"].ToString();
        //            if (rdr["MoreInfoFromAgencyRequestedDate"] != DBNull.Value)
        //                record.MoreInfoFromAgencyRequestedDate = Convert.ToDateTime(rdr["MoreInfoFromAgencyRequestedDate"]);
        //            record.MoreInfoFromAgencyRequested = rdr["MoreInfoFromAgencyRequested"].ToString();
        //            record.MoreInfoFromAgencyReceived = rdr["MoreInfoFromAgencyReceived"].ToString();
        //            if (rdr["MoreInfoFromAgencyReceivedDate"] != DBNull.Value)
        //                record.MoreInfoFromAgencyReceivedDate = Convert.ToDateTime(rdr["MoreInfoFromAgencyReceivedDate"]);
        //            record.OwnerResponse = rdr["OwnerResponse"].ToString();
        //            if (rdr["OwnerResponseDate"] != DBNull.Value)
        //                record.OwnerResponseDate = Convert.ToDateTime(rdr["OwnerResponseDate"]);
        //            record.OwnerResponseDays = rdr["OwnerResponseDays"].ToString();
        //            if (rdr["AgencyResponseToDebtorDate"] != DBNull.Value)
        //                record.AgencyResponseToDebtorDate = Convert.ToDateTime(rdr["AgencyResponseToDebtorDate"]);
        //            record.TotalResponseTimeDays = rdr["TotalResponseTimeDays"].ToString();
        //            record.DebtorAgree = rdr["DebtorAgreeText"].ToString();
        //            record.NeedFurtherAction = rdr["NeedFurtherActionText"].ToString();
        //            record.FinalActionStep = rdr["FinalActionStep"].ToString();
        //            record.IsViewedByOwner = rdr["IsViewedByOwnerText"].ToString();
        //            record.IsViewedByAgency = rdr["IsViewedByAgencyText"].ToString();
        //            record.CreatedBy = rdr["CreatedBy"].ToString();

        //            if (record.DebtPurchaseBalance == Convert.ToDecimal(0.0))
        //            {
        //                record.DebtPurchaseBalance = null;
        //            }
        //            if (record.DebtCurrentBalance == Convert.ToDecimal(0.0))
        //            {
        //                record.DebtCurrentBalance = null;
        //            }
        //            if (record.ComplaintDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintDate = null;
        //            }
        //            if (record.ComplaintSubmitedToAgencyDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintSubmitedToAgencyDate = null;
        //            }
        //            if (record.MoreInfoRequestedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.MoreInfoRequestedDate = null;
        //            }
        //            if (record.MoreInfoReceivedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.MoreInfoReceivedDate = null;
        //            }
        //            if (record.ComplaintSubmittedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintSubmittedDate = null;
        //            }
        //            if (record.MoreInfoFromAgencyRequestedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.MoreInfoFromAgencyRequestedDate = null;
        //            }
        //            if (record.MoreInfoFromAgencyReceivedDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.MoreInfoFromAgencyReceivedDate = null;
        //            }
        //            if (record.OwnerResponseDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.OwnerResponseDate = null;
        //            }
        //            if (record.AgencyResponseToDebtorDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.AgencyResponseToDebtorDate = null;
        //            }

        //            data.Add(record);
        //        }
        //        //Close the datareader
        //        rdr.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        //ErrorLogHelper.Error(logMessage, ex);
        //        throw new Exception("Exception in DataQueries.GetComplianceNCRAReportRecords:" + ex.Message);
        //    }
        //    return data.AsEnumerable<ComplianceViewResult>();
        //}

    }

}
