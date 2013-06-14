using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using MSI.CCAT.WEB.Models;
using MSI.CCAT.WEB.Controllers;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.WEB.ApplicationIntegration;
using MSI.CCAT.WEB.ViewModels;

using Cascade.Data.Repositories;
using Cascade.Data.Models;

using System.Data.SqlClient;
using System.Data;


namespace MSI.CCAT.WEB.Areas.Compliance.Controllers
{
    public class HomeController : BaseController
    {
        private IFileProcessor fileProcessor = new FileProcessor();
        //
        // GET: /Compliance/Home/

        public ActionResult Index()
        {
            //return View();
            return PartialView();
        }

        public ActionResult ComplianceReport(string reportType)
        {
            //Save the Report Type in ViewBag. It will be stored in the Hidden field on the Page
            ViewBag.ReportType = reportType;
            pageInfo _pageInfo = new pageInfo() { title = "Report " + reportType };
            _pageInfo.LayoutPage = "";
            return View("Report" + reportType, _pageInfo);
        }
        
        //public ActionResult GetReportData(string ReportType)
        //{
        //    var dataQueries = new DataQueries();
        //    IEnumerable<ComplianceViewResult> results;
        //    //For Report based on Report Type selection
        //    results = dataQueries.GetComplianceReportRecords("", ReportType);
        //    ViewBag.ReportType = ReportType;
        //    return PartialView("_compliance" + ReportType, results);

        //}

        public static List<ComplianceReportResult_Ext> GetReportData(string where, string OrderBy, int pageSize, int pageNo, string reportType)
        {
            DBFactory db;
            SqlDataReader rdr;
            List<ComplianceReportResult_Ext> data = null;
            string SQL = "";
            if (reportType == "NCRA")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_NCRAReportExtendable, where) : _sql_base_NCRAReport);
            }
            else if (reportType == "RC")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_RCReportExtendable, where) : _sql_base_RCReport);
            }
            else if (reportType == "AAI")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_AAIReportExtendable, where) : _sql_base_AAIReport);
            }
            else if (reportType == "NCP")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_NCPReportExtendable, where) : _sql_base_NCPReport);
            }
            else if (reportType == "ORP")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_ORPReportExtendable, where) : _sql_base_ORPReport);
            }
            else if (reportType == "SOA")
            {
                SQL = (!string.IsNullOrEmpty(where) ? string.Format(_sql_base_SOAReportExtendable, where) : _sql_base_SOAReport);
            } 
            try
            {
                db = new DBFactory("CascadeDBEntities"); // We are connecting to CascadeDB
                rdr = db.ExecuteReader("get_pagedDataSet", new SqlParameter("@SQL", SQL), new SqlParameter("@OrderBy", OrderBy), new SqlParameter("@pageSize", pageSize), new SqlParameter("@pageNo", pageNo));
                data = new List<ComplianceReportResult_Ext>();
                ComplianceReportResult_Ext record;
                while (rdr.Read())
                {
                    record = new ComplianceReportResult_Ext();
                    
                    record.AgencyId = rdr["AgencyId"].ToString();
                    record.AgencyName = rdr["AgencyName"].ToString();
                    record.LastName = rdr["LastName"].ToString();
                    record.FirstName = rdr["FirstName"].ToString();
                    record.PIMSAccount = rdr["PIMSAccount"].ToString();
                    record.ComPlaintId = rdr["ComPlaintId"].ToString();
                    record.HomePhone = rdr["HomePhone"].ToString();
                    record.WorkPhone = rdr["WorkPhone"].ToString();
                    record.MobilePhone = rdr["MobilePhone"].ToString();
                    record.LastFourSSN = rdr["LastFourSSN"].ToString();
                    if (rdr["ComplaintDate"] != DBNull.Value)
                        record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
                    if (rdr["MoreInfoRequestedDate"] != DBNull.Value)
                        record.MoreInfoRequestedDate = Convert.ToDateTime(rdr["MoreInfoRequestedDate"]);
                    if (rdr["ComplaintSubmittedDate"] != DBNull.Value)
                        record.ComplaintSubmittedDate = Convert.ToDateTime(rdr["ComplaintSubmittedDate"]);
                    if (rdr["AgencyResponseToDebtorDate"] != DBNull.Value)
                        record.AgencyResponseToDebtorDate = Convert.ToDateTime(rdr["AgencyResponseToDebtorDate"]);
                    if (rdr["TotalResponseTimeDays"] != DBNull.Value)
                        record.TotalResponseTimeDays = Convert.ToInt32(rdr["TotalResponseTimeDays"]);
                    if (rdr["count_"] != DBNull.Value)
                        record.count_ = Convert.ToInt32(rdr["count_"]);
                    if (rdr["rowNo"] != DBNull.Value)
                        record.rowNo = Convert.ToInt64(rdr["rowNo"]);
                    
                    if (record.ComplaintDate.ToString() == "1/1/1900 12:00:00 AM")
                    {
                        record.ComplaintDate = null;
                    }
                    if (record.MoreInfoRequestedDate.ToString() == "1/1/1900 12:00:00 AM")
                    {
                        record.MoreInfoRequestedDate = null;
                    }
                    if (record.ComplaintSubmittedDate.ToString() == "1/1/1900 12:00:00 AM")
                    {
                        record.ComplaintSubmittedDate = null;
                    }
                    if (record.AgencyResponseToDebtorDate.ToString() == "1/1/1900 12:00:00 AM")
                    {
                        record.AgencyResponseToDebtorDate = null;
                    }
                    data.Add(record);
                }
                //Close the datareader
                rdr.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("Exception in DataQueries.GetReportData:" + ex.Message);
            }
            return data;
        }

        #region [ If a SQL reserved word is entered in "Search Text", skip the word ]
        public static string kill_sqlBlacklistWord(string searchText)
        {
            const string _BLACKLIST = @"--,;,/*,*/,@@,char,nchar,varchar,nvarchar,"
                                      + @"alter,begin,cast,create,cursor,declare,delete,drop,end,exec,"
                                      + @"execute,fetch,insert,kill,open,select,sys,sysobjects,syscolumns,table,update";

            string[] _blackList = _BLACKLIST.Split(',');

            foreach (string a in _blackList)
                searchText = searchText.Replace(a, "");

            return searchText;
        }
        #endregion


        [HttpGet]
        public JsonResult GetComplianceReportData(string searchText, string reportType, int? page, int? pageSize)
        {
            #region [ Retrieve "Sort" options ]
            string sortField = HttpContext.Request.QueryString["sort[0][field]"];
            string sortDir = HttpContext.Request.QueryString["sort[0][dir]"];

            int _pageSize = (pageSize == null ? 10 : pageSize.Value);
            int _pageNo = (page == null ? 1 : page.Value);

            string _sortOptions = "";
            if (!string.IsNullOrEmpty(sortField))
                _sortOptions = sortField;
            if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortDir))
                _sortOptions = _sortOptions + " " + sortDir;
            #endregion

            #region [[ For NCRA, RC, AAI, NCP, ORP, SOA Report ]]
            List<ComplianceReportResult_Ext> _list = new List<ComplianceReportResult_Ext>();
            if (!string.IsNullOrEmpty(searchText))
            {
                searchText = kill_sqlBlacklistWord(searchText);

                if (string.IsNullOrEmpty(_sortOptions))
                    _sortOptions = "AgencyId";

                string _where = "";

                if (!string.IsNullOrEmpty(searchText))
                {
                    #region [ Split Search Text > string1, string2 & string3 and create "Where" statement ]
                    char[] delimiterChars = { ' ', ',', '.', ';', ':', '|', '\t' };

                    string[] words = searchText.Split(delimiterChars);

                    if (words.Count() > 0)
                    {
                        _where = string.Format("cm.ComPlaintId LIKE ''%{0}%'' OR cm.LastName LIKE ''%{0}%''", words[0]);
                        for (int i = 1; i < words.Length; i++)
                        {
                            _where = _where + string.Format("OR cm.ComPlaintId LIKE ''%{0}%'' OR cm.LastName LIKE ''%{0}%''", words[i]);
                        }
                        _where = "and (" + _where + ")";
                        
                        if (string.IsNullOrEmpty(_sortOptions)) _sortOptions = "AgencyId ASC";
                        _list = GetReportData(_where, _sortOptions, _pageSize, _pageNo, reportType);
                    }
                    #endregion
                }

            }
            else
            {
                //Coming here when SearchText is null
                if (string.IsNullOrEmpty(_sortOptions)) _sortOptions = "AgencyId ASC";
                _list = GetReportData("", _sortOptions, _pageSize, _pageNo, reportType);
            }
            #endregion

            

            //Now send back the Json Response
            if (_list.Count() > 0)
            {
                return Json(new { success = true, __count = _list.FirstOrDefault().count_, results = _list.ToList() }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = true, __count = 0 }, JsonRequestBehavior.AllowGet);
            }

        }

        #region [[ SQL Statements for Reports ]]
        const string _sql_base_NCRAReportExtendable = _sql_base_NCRAReport + "{0}";
        const string _sql_base_RCReportExtendable = _sql_base_RCReport + "{0}";
        const string _sql_base_AAIReportExtendable = _sql_base_AAIReport + "{0}";
        const string _sql_base_NCPReportExtendable = _sql_base_NCPReport + "{0}";
        const string _sql_base_ORPReportExtendable = _sql_base_ORPReport + "{0}";
        const string _sql_base_SOAReportExtendable = _sql_base_SOAReport + "{0}";

        const string _sql_base_NCRAReport =
                @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'''') as LastName, 
			Isnull(cm.FirstName,'''') as FirstName,
			Isnull(cm.Account,'''') as PIMSAccount,
			Isnull(cm.ComPlaintId,'''') as ComPlaintId,
			Isnull(cm.HomePhone,'''') as HomePhone,
			Isnull(cm.WorkPhone,'''') as WorkPhone,
			Isnull(cm.MobilePhone,'''') as MobilePhone,
			Isnull(cm.LastFourSSN,'''') as LastFourSSN,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
            Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.ComplaintSubmitedToAgencyYN = 1
			and cm.ComplaintSubmitedToAgencyDate is not null
			";
        const string _sql_base_RCReport =
                @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'') as LastName, 
			Isnull(cm.FirstName,'') as FirstName,
			Isnull(cm.Account,'') as PIMSAccount,
			Isnull(cm.ComPlaintId,'') as ComPlaintId,		
			Isnull(cm.LastFourSSN,'') as LastFourSSN,
			Isnull(cm.HomePhone,'') as HomePhone,
		    Isnull(cm.WorkPhone,'') as WorkPhone,
		    Isnull(cm.MobilePhone,'') as MobilePhone,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
			Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays			
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.DebtorAgreeYN=1 and FinalActionStepId is not null 
            ";
        const string _sql_base_AAIReport =
               @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'') as LastName, 
			Isnull(cm.FirstName,'') as FirstName,
			Isnull(cm.Account,'') as PIMSAccount,
			Isnull(cm.ComPlaintId,'') as ComPlaintId,		
			Isnull(cm.LastFourSSN,'') as LastFourSSN,
			Isnull(cm.HomePhone,'') as HomePhone,
		    Isnull(cm.WorkPhone,'') as WorkPhone,
		    Isnull(cm.MobilePhone,'') as MobilePhone,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
			Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.ComplaintSubmitedToAgencyDate is not null
			and cm.MoreInfoReqdFromDebtorYN=1 
            ";

        const string _sql_base_NCPReport =
                @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'') as LastName, 
			Isnull(cm.FirstName,'') as FirstName,
			Isnull(cm.Account,'') as PIMSAccount,
			Isnull(cm.ComPlaintId,'') as ComPlaintId,		
			Isnull(cm.LastFourSSN,'') as LastFourSSN,
			Isnull(cm.HomePhone,'') as HomePhone,
		    Isnull(cm.WorkPhone,'') as WorkPhone,
		    Isnull(cm.MobilePhone,'') as MobilePhone,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
			Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays		
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.ComplaintSubmitedToAgencyDate is not null
			and ISNULL(cm.ComplaintSubmittedToOwnerYN,0) = 0
			";

        const string _sql_base_ORPReport =
                 @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'') as LastName, 
			Isnull(cm.FirstName,'') as FirstName,
			Isnull(cm.Account,'') as PIMSAccount,
			Isnull(cm.ComPlaintId,'') as ComPlaintId,		
			Isnull(cm.LastFourSSN,'') as LastFourSSN,
			Isnull(cm.HomePhone,'') as HomePhone,
		    Isnull(cm.WorkPhone,'') as WorkPhone,
		    Isnull(cm.MobilePhone,'') as MobilePhone,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
			Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.ComplaintSubmittedToOwnerYN=1 and cm.IsViewedByOwner=1
          ";


        const string _sql_base_SOAReport =
                  @"Select 
			cm.AgencyId,  ra.NAME as AgencyName,
			Isnull(cm.LastName,'') as LastName, 
			Isnull(cm.FirstName,'') as FirstName,
			Isnull(cm.Account,'') as PIMSAccount,
			Isnull(cm.ComPlaintId,'') as ComPlaintId,		
			Isnull(cm.LastFourSSN,'') as LastFourSSN,
			Isnull(cm.HomePhone,'') as HomePhone,
		    Isnull(cm.WorkPhone,'') as WorkPhone,
		    Isnull(cm.MobilePhone,'') as MobilePhone,
			Convert(varchar(20),ComplaintDate,101) as ComplaintDate,
			Convert(varchar(20),AgencyResponseToDebtorDate,101) as AgencyResponseToDebtorDate,
			Convert(varchar(20),MoreInfoRequestedDate,101) as MoreInfoRequestedDate,
			Convert(varchar(20),ComplaintSubmittedDate,101) as ComplaintSubmittedDate,
			cm.TotalResponseTimeDays
			from MSI_ComplaintMain cm
			inner join RAGENCY ra on ra.AGENCY_ID = cm.AgencyId
			where cm.ComplaintSubmittedToOwnerYN=1 
            ";

        #endregion
        
        public ActionResult Export(string ReportType)
        {
            Response.AddHeader("Content-Type", "application/vnd.ms-excel");
            var dataQueries = new DataQueries();
            IEnumerable<ComplianceViewResult> results;
            ViewBag.ReportType = ReportType;

            results = dataQueries.GetComplianceReportRecordsExport("", ReportType);

            return PartialView("Export", results);

        }
        
        //
        // GET: /Compliance/Home/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Compliance/Home/Create

        public ActionResult Create()
        {
            //ViewBag.UserID = UserId.ToString();
            //ViewBag.AgencyID = "";
            //ViewBag.UserRole = UserRoles.First().ToLower();
            return PartialView();
        }

        public ActionResult ViewEdit(string id, string agency)
        {
            //ViewBag.UserID = UserId.ToString();
            ViewBag.Account = (string.IsNullOrEmpty(id)) ? "" : id; ;
            ViewBag.AgencyID = (string.IsNullOrEmpty("agency")) ? "" : agency;
  //          ViewBag.UserRole = UserRoles.First().ToLower();
            return PartialView();
        }

        //
        // POST: /Compliance/Home/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Compliance/Home/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Compliance/Home/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Compliance/Home/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Compliance/Home/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult UploadDocument()
        {
            string account = Request.Form["hdnAccount"];
            string agency = Request.Form["hdnAgency"];
            string complaintDocument, debtOwnerProcessDocument;
            complaintDocument = Request.Files["complaintDocument"].FileName;
            debtOwnerProcessDocument = Request.Files["debtOwnerProcessDocument"].FileName;
            //MSI.CCAT.Data.Repositories.MSI_ComplaintMainRepository repository = new MSI_ComplaintMainRepository();
            UnitOfWork uo = new UnitOfWork("CascadeDBEntities");
            MSI.CCAT.Data.Models.MSI_ComplaintMain complaint = (from existingComplaint in uo.Repository<MSI.CCAT.Data.Models.MSI_ComplaintMain>().GetAll().Where(record => record.AgencyId == agency && record.Account == account)
                                                                select existingComplaint).First();
            if (!string.IsNullOrEmpty(complaintDocument))
            {
                complaint.ComplaintDocument = fileProcessor.SaveUploadedFile(Request.Files["complaintDocument"]) + "_" + complaintDocument;
                //repository.Update(complaint);
                uo.Repository<MSI.CCAT.Data.Models.MSI_ComplaintMain>().Update(complaint);
                uo.Save();
            }
            if (!string.IsNullOrEmpty(debtOwnerProcessDocument))
            {
                complaint.DebtOwnerProcessDocument = fileProcessor.SaveUploadedFile(Request.Files["debtOwnerProcessDocument"]) + "_" + debtOwnerProcessDocument;
                //repository.Update(complaint);
                uo.Repository<MSI.CCAT.Data.Models.MSI_ComplaintMain>().Update(complaint);
                uo.Save();
            }
            return RedirectToAction("ViewEdit", "Home", new { id = account, agency = agency });

        }

        public FilePathResult DownloadDoc(string fileName)
        {
            return File(fileProcessor.GetFilePath(fileName), "text/plain", fileName.Split(new char[] { '_' })[1]);
        }
    }
}
