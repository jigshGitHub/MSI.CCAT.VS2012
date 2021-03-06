﻿using System;
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

//using Cascade.Data.Repositories;
using MSI.Data.Models;

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
            ViewBag.RoleEntityValue = RoleEntityValue;
            ViewBag.UserRole = UserRoles.First();
            pageInfo _pageInfo = new pageInfo() { title = "Report " + reportType };
            _pageInfo.LayoutPage = "";
            return View("Report" + reportType, _pageInfo);
        }

        public ActionResult FilteredComplaints()
        {            
            ViewBag.RoleEntityValue = RoleEntityValue;
            ViewBag.UserRole = UserRoles.First();
            ViewBag.UserId = UserId.ToString();
            pageInfo _pageInfo = new pageInfo() { title = "Filtered Complaints" };
            _pageInfo.LayoutPage = "";
            return View(_pageInfo);
        }

        [HttpGet]
        public JsonResult GetComplianceReportDataFiltered(string searchText, string managerIds, string collectorIds, int? page, int? pageSize)
        {
            DBFactory db;
            SqlDataReader rdr;
            List<ComplianceReportResult_Ext> data = null;
            string sortOptions = BuildCommonReportSortOptions(HttpContext.Request.QueryString["sort[0][field]"], HttpContext.Request.QueryString["sort[0][dir]"]);
            
            try
            {
                db = new DBFactory("CCATDBEntities");
                rdr = db.ExecuteReader("sp_FilteredReportSearch", new SqlParameter("@userId", UserId.ToString()), new SqlParameter("@collectorUserIds", collectorIds), new SqlParameter("@OrderBy", sortOptions), new SqlParameter("@pageSize", (pageSize.HasValue ? pageSize.Value : 10)), new SqlParameter("@pageNo", (page.HasValue ? page.Value : 1)));
                data = new List<ComplianceReportResult_Ext>();
                ComplianceReportResult_Ext record;
                while (rdr.Read())
                {
                    record = new ComplianceReportResult_Ext();

                    record.LastName = rdr["LastName"].ToString();
                    record.FirstName = rdr["FirstName"].ToString();
                    record.FullName = rdr["LastName"].ToString() + " " + rdr["FirstName"].ToString();
                    if (!string.IsNullOrEmpty(rdr["AgentLastName"].ToString()))
                    {
                        record.AgentLastName = rdr["AgentLastName"].ToString();
                        record.AgentFullName = rdr["AgentLastName"].ToString() + " " + rdr["AgentFirstName"].ToString();
                    }
                    if (!string.IsNullOrEmpty(rdr["AgentFirstName"].ToString()))
                    {
                        record.AgentFirstName = rdr["AgentFirstName"].ToString();
                        record.AgentFullName = record.AgentFullName + " " + rdr["AgentFirstName"].ToString();
                    }
                    record.ComPlaintId = rdr["ComPlaintId"].ToString();
                    record.LastFourSSN = rdr["LastFourSSN"].ToString();
                    record.AccountNumber = rdr["Accountnumber"].ToString();

                    if (rdr["AgencyId"] != DBNull.Value)
                        record.AgencyId = rdr["AgencyId"].ToString();

                    if (rdr["ComplaintIssue"] != DBNull.Value)
                        record.ComplaintIssue = rdr["ComplaintIssue"].ToString();
                    if (rdr["ComplaintDate"] != DBNull.Value)
                        record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
                    if (rdr["ResolvedDate"] != DBNull.Value)
                        record.ResolvedDate = Convert.ToDateTime(rdr["ResolvedDate"]);
                    if (rdr["DateRequested"] != DBNull.Value)
                        record.DateRequested = Convert.ToDateTime(rdr["DateRequested"]);
                    if (rdr["DateSubmitted"] != DBNull.Value)
                        record.DateSubmitted = Convert.ToDateTime(rdr["DateSubmitted"]);
                    if (rdr["AgencyRequestDate"] != DBNull.Value)
                        record.AgencyRequestDate = Convert.ToDateTime(rdr["AgencyRequestDate"]);
                    if (rdr["OwnerResponseDate"] != DBNull.Value)
                        record.OwnerResponseDate = Convert.ToDateTime(rdr["OwnerResponseDate"]);
                    if (rdr["UpdatedDateTime"] != DBNull.Value)
                        record.UpdatedDateTime = Convert.ToDateTime(rdr["UpdatedDateTime"]);
                    if (rdr["ResponseTimeDays"] != DBNull.Value)
                        record.ResponseTimeDays = Convert.ToInt32(rdr["ResponseTimeDays"]);
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
                    data.Add(record);

                }
                //Close the datareader
                rdr.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("Exception in DataQueries.GetReportData:" + ex.Message);
            }

            if (data.Count() > 0)
            {
                return Json(new { success = true, __count = data.FirstOrDefault().count_, results = data.ToList() }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = true, __count = 0 }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetComplianceReportData(string searchText, string reportType, string roleEntityValue, string hdnUserRole, int? page, int? pageSize)
        {
            string sortOptions = BuildCommonReportSortOptions(HttpContext.Request.QueryString["sort[0][field]"], HttpContext.Request.QueryString["sort[0][dir]"]);
            string whereClause = BuildCommonReportWhereClause(reportType, RoleEntityValue, UserRoles.First(), searchText);

            List<ComplianceReportResult_Ext> _list = BuildCommonReport(whereClause, sortOptions, (pageSize.HasValue ? pageSize.Value : 10), (page.HasValue ? page.Value : 1));


            if (_list.Count() > 0)
            {
                return Json(new { success = true, __count = _list.FirstOrDefault().count_, results = _list.ToList() }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = true, __count = 0 }, JsonRequestBehavior.AllowGet);
            }

        }

        #region Not Used
        //public ActionResult GetReportData(string ReportType)
        //{
        //    var dataQueries = new DataQueries();
        //    IEnumerable<ComplianceViewResult> results;
        //    //For Report based on Report Type selection
        //    results = dataQueries.GetComplianceReportRecords("", ReportType);
        //    ViewBag.ReportType = ReportType;
        //    return PartialView("_compliance" + ReportType, results);

        //}
        
        //public static List<ComplianceReportResult_Ext> GetReportData(string roleEntityValue, string hdnUserRole, string where, string OrderBy, int pageSize, int pageNo, string reportType)
        //{
        //    DBFactory db;
        //    SqlDataReader rdr;
        //    List<ComplianceReportResult_Ext> data = null;

        //    //Get the Base SQL statement
        //    string _sql_base_ReportQuery_rt = string.Format(_sql_base_ReportQuery, reportType);

        //    //Now change based on the role
        //    if (hdnUserRole == "CollectionAgency"
        //        || hdnUserRole == "DebtOwner"
        //        || hdnUserRole == "AgencyCollector"
        //        || hdnUserRole == "AgencyManager"
        //        || hdnUserRole == "AgencyCompliance")
        //    {
        //        //Then we need to change the SQL
        //        if (hdnUserRole == "CollectionAgency" || hdnUserRole == "AgencyCollector" || hdnUserRole == "AgencyManager" || hdnUserRole == "AgencyCompliance")
        //        {
        //            _sql_base_ReportQuery_rt = _sql_base_ReportQuery_rt + " and ag.Name = '{0}'";

        //        }
        //        if (hdnUserRole == "DebtOwner")
        //        {
        //            _sql_base_ReportQuery_rt = _sql_base_ReportQuery_rt + " and act.OwnerId = {0}";

        //        }
        //        _sql_base_ReportQuery_rt = string.Format(_sql_base_ReportQuery_rt, roleEntityValue);

        //    }


        //    string SQL = "";
        //    SQL = (!string.IsNullOrEmpty(where) ? _sql_base_ReportQuery_rt + " " + where : _sql_base_ReportQuery_rt);

        //    try
        //    {
        //        db = new DBFactory("CCATDBEntities");
        //        rdr = db.ExecuteReader("get_pagedDataSet", new SqlParameter("@SQL", SQL), new SqlParameter("@OrderBy", OrderBy), new SqlParameter("@pageSize", pageSize), new SqlParameter("@pageNo", pageNo));
        //        data = new List<ComplianceReportResult_Ext>();
        //        ComplianceReportResult_Ext record;
        //        while (rdr.Read())
        //        {
        //            record = new ComplianceReportResult_Ext();

        //            record.LastName = rdr["LastName"].ToString();
        //            record.FirstName = rdr["FirstName"].ToString();
        //            record.ComPlaintId = rdr["ComPlaintId"].ToString();
        //            record.LastFourSSN = rdr["LastFourSSN"].ToString();
        //            record.AccountNumber = rdr["Accountnumber"].ToString();

        //            if (rdr["AgencyId"] != DBNull.Value)
        //                record.AgencyId = rdr["AgencyId"].ToString();

        //            if (rdr["ComplaintIssue"] != DBNull.Value)
        //                record.ComplaintIssue = rdr["ComplaintIssue"].ToString();
        //            if (rdr["ComplaintDate"] != DBNull.Value)
        //                record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
        //            if (rdr["ResolvedDate"] != DBNull.Value)
        //                record.ResolvedDate = Convert.ToDateTime(rdr["ResolvedDate"]);
        //            if (rdr["DateRequested"] != DBNull.Value)
        //                record.DateRequested = Convert.ToDateTime(rdr["DateRequested"]);
        //            if (rdr["DateSubmitted"] != DBNull.Value)
        //                record.DateSubmitted = Convert.ToDateTime(rdr["DateSubmitted"]);
        //            if (rdr["AgencyRequestDate"] != DBNull.Value)
        //                record.AgencyRequestDate = Convert.ToDateTime(rdr["AgencyRequestDate"]);
        //            if (rdr["OwnerResponseDate"] != DBNull.Value)
        //                record.OwnerResponseDate = Convert.ToDateTime(rdr["OwnerResponseDate"]);
        //            if (rdr["ResponseTimeDays"] != DBNull.Value)
        //                record.ResponseTimeDays = Convert.ToInt32(rdr["ResponseTimeDays"]);
        //            if (rdr["TotalResponseTimeDays"] != DBNull.Value)
        //                record.TotalResponseTimeDays = Convert.ToInt32(rdr["TotalResponseTimeDays"]);

        //            if (rdr["count_"] != DBNull.Value)
        //                record.count_ = Convert.ToInt32(rdr["count_"]);
        //            if (rdr["rowNo"] != DBNull.Value)
        //                record.rowNo = Convert.ToInt64(rdr["rowNo"]);

        //            if (record.ComplaintDate.ToString() == "1/1/1900 12:00:00 AM")
        //            {
        //                record.ComplaintDate = null;
        //            }
        //            data.Add(record);

        //        }
        //        //Close the datareader
        //        rdr.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("Exception in DataQueries.GetReportData:" + ex.Message);
        //    }
        //    return data;
        //}
        #endregion
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

        #region OLD GetComplianceReportData
        //[HttpGet]
        //public JsonResult GetComplianceReportData(string searchText, string reportType, string roleEntityValue, string hdnUserRole, int? page, int? pageSize)
        //{
        //    #region [[ Let us make sure we have correct information for Searching....]]
        //    //Agency Name
        //    roleEntityValue = RoleEntityValue;
        //    //User Role
        //    hdnUserRole = UserRoles.First();
        //    #endregion

        //    #region [ Retrieve "Sort" options ]
        //    string sortField = HttpContext.Request.QueryString["sort[0][field]"];
        //    string sortDir = HttpContext.Request.QueryString["sort[0][dir]"];

        //    int _pageSize = (pageSize == null ? 10 : pageSize.Value);
        //    int _pageNo = (page == null ? 1 : page.Value);

        //    string _sortOptions = "";
        //    if (!string.IsNullOrEmpty(sortField))
        //        _sortOptions = sortField;
        //    if (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortDir))
        //        _sortOptions = _sortOptions + " " + sortDir;
        //    #endregion

        //    #region [[ For NCRA, RC, AAI, NCIP, ORIP, SFOA Report ]]
        //    List<ComplianceReportResult_Ext> _list = new List<ComplianceReportResult_Ext>();
        //    if (!string.IsNullOrEmpty(searchText))
        //    {
        //        searchText = kill_sqlBlacklistWord(searchText);

        //        if (string.IsNullOrEmpty(_sortOptions))
        //            _sortOptions = "ComplaintId";

        //        string _where = "";

        //        if (!string.IsNullOrEmpty(searchText))
        //        {
        //            #region [ Split Search Text > string1, string2 & string3 and create "Where" statement ]
        //            char[] delimiterChars = { ' ', ',', '.', ';', ':', '|', '\t' };

        //            string[] words = searchText.Split(delimiterChars);

        //            if (words.Count() > 0)
        //            {
        //                _where = string.Format("cm.ComPlaintId LIKE '%{0}%' OR act.LastName LIKE '%{0}%'", words[0]);
        //                for (int i = 1; i < words.Length; i++)
        //                {
        //                    _where = _where + string.Format("OR cm.ComPlaintId LIKE '%{0}%' OR act.LastName LIKE '%{0}%'", words[i]);
        //                }
        //                _where = "and (" + _where + ")";

        //                if (string.IsNullOrEmpty(_sortOptions)) _sortOptions = "ComplaintId ASC";
        //                _list = GetReportData(roleEntityValue, hdnUserRole, _where, _sortOptions, _pageSize, _pageNo, reportType);
        //            }
        //            #endregion
        //        }

        //    }
        //    else
        //    {
        //        //Coming here when SearchText is null
        //        if (string.IsNullOrEmpty(_sortOptions)) _sortOptions = "ComplaintId ASC";
        //        _list = GetReportData(roleEntityValue, hdnUserRole, "", _sortOptions, _pageSize, _pageNo, reportType);
        //    }
        //    #endregion


        //    //Now send back the Json Response
        //    if (_list.Count() > 0)
        //    {
        //        return Json(new { success = true, __count = _list.FirstOrDefault().count_, results = _list.ToList() }, JsonRequestBehavior.AllowGet);
        //    }
        //    else
        //    {
        //        return Json(new { success = true, __count = 0 }, JsonRequestBehavior.AllowGet);
        //    }

        //}
        #endregion
        #region [[ SQL Statements for Reports ]]
        const string _sql_base_ReportQuery = @"SELECT  
			cm.ComplaintId,
			cm.AccountNumber,  
			ISNULL (act.LastName,'''') as LastName, 
			ISNULL(act.FirstName,'''') as FirstName,
			ISNULL(act.LastFourSSN,'''') as LastFourSSN,
            -- Field no 28
			CONVERT(varchar(20),cm.ComplaintDate,101) as ComplaintDate,
            -- Field no 36
			CONVERT(varchar(20),cm.MoreInfoRequestedDate,101) as DateRequested,
            -- Field no 42
			CONVERT(varchar(20),cm.ComplaintSubmittedDate,101) as DateSubmitted,
			CONVERT(varchar(20),cm.MoreInfoFromAgencyRequestedDate,101) as AgencyRequestDate,
			CONVERT(varchar(20),cm.AgencyResponseToDebtorDate,101) as ResolvedDate,
			ci.Name as ComplaintIssue,
			cm.TotalResponseTimeDays,0 as ResponseTimeDays,
			ag.Name AS AgencyId,            
			cm.OwnerResponseDate
			FROM Tbl_ComplaintMain cm
			INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
			INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
			INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
			INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId
			WHERE cs.Value = '{0}'";

        #endregion

        //public ActionResult Export(string ReportType)
        //{
        //    Response.AddHeader("Content-Type", "application/vnd.ms-excel");
        //    var dataQueries = new DataQueries();
        //    IEnumerable<ComplianceViewResult> results;
        //    ViewBag.ReportType = ReportType;

        //    results = dataQueries.GetComplianceReportRecordsExport("", ReportType);

        //    return PartialView("Export", results);

        //}

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

        public ActionResult ViewEdit(string id, string agency, string complaintId)
        {
            //ViewBag.UserID = UserId.ToString();
            ViewBag.Account = (string.IsNullOrEmpty(id)) ? "" : id;
            ViewBag.ComplaintID = (string.IsNullOrEmpty(complaintId)) ? "" : complaintId;
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
        public JsonResult UploadDocument()
        {
            string account = Request.Form["hdnAccount"];
            string complaintId = Request.Form["hdnComplaintId"];
            string agency = Request.Form["hdnAgency"];
            string complaintDocument, debtOwnerProcessDocument;
            complaintDocument = Request.Files["complaintDocument"].FileName;
            debtOwnerProcessDocument = Request.Files["debtOwnerProcessDocument"].FileName;
            UnitOfWork uo = new UnitOfWork("CCATDBEntities");
            MSI.CCAT.Data.Models.Tbl_ComplaintMain complaint = (from existingComplaint in uo.Repository<MSI.CCAT.Data.Models.Tbl_ComplaintMain>().GetAll().Where(record => record.AccountNumber == account && record.ComplaintId == complaintId)
                                                                select existingComplaint).First();
            string fileGuid = "";
            string fileName = "";
            if (!string.IsNullOrEmpty(complaintDocument))
            {
                complaint.ComplaintDocument = fileProcessor.SaveUploadedFile(Request.Files["complaintDocument"]) + "_" + complaintDocument;
                uo.Repository<MSI.CCAT.Data.Models.Tbl_ComplaintMain>().Update(complaint);
                uo.Save();
                fileGuid = complaint.ComplaintDocument;
                fileName = complaintDocument;
            }
            if (!string.IsNullOrEmpty(debtOwnerProcessDocument))
            {
                complaint.DebtOwnerProcessDocument = fileProcessor.SaveUploadedFile(Request.Files["debtOwnerProcessDocument"]) + "_" + debtOwnerProcessDocument;
                uo.Repository<MSI.CCAT.Data.Models.Tbl_ComplaintMain>().Update(complaint);
                uo.Save();
                fileGuid = complaint.DebtOwnerProcessDocument;
                fileName = debtOwnerProcessDocument;
            }
            ViewBag.Account = (string.IsNullOrEmpty(account)) ? "" : account;
            ViewBag.AgencyID = (string.IsNullOrEmpty(agency)) ? "" : agency;
            return Json(new { success = true, fileGuid = fileGuid, file = fileName }, JsonRequestBehavior.AllowGet);

        }

        public FilePathResult DownloadDoc(string fileName)
        {
            return File(fileProcessor.GetFilePath(fileName), "text/plain", fileName.Split(new char[] { '_' })[1]);
        }

        #region Private Functions/Methods

        private string BuildWhereBasedOnSearchText(string searchText)
        {
            string where = "";

            #region [[ For NCRA, RC, AAI, NCIP, ORIP, SFOA Report ]]
            if (!string.IsNullOrEmpty(searchText))
            {
                searchText = kill_sqlBlacklistWord(searchText);

                if (!string.IsNullOrEmpty(searchText))
                {
                    #region [ Split Search Text > string1, string2 & string3 and create "Where" statement ]
                    char[] delimiterChars = { ' ', ',', '.', ';', ':', '|', '\t' };

                    string[] words = searchText.Split(delimiterChars);

                    if (words.Count() > 0)
                    {
                        where = string.Format(" cm.ComplaintId LIKE '%{0}%' OR act.LastName LIKE '%{0}%'", words[0]);
                        for (int i = 1; i < words.Length; i++)
                        {
                            where = where + string.Format(" OR cm.ComplaintId LIKE '%{0}%' OR act.LastName LIKE '%{0}%'", words[i]);
                        }
                        where = " and (" + where + ")";
                    }
                    #endregion
                }

            }
            #endregion
            return where;
        }

        private string BuildCommonReportWhereClause(string reportType, string roleEntityValue, string hdnUserRole, string searchText)
        {
            string where = " WHERE cs.Value = '" + reportType + "'";

            where = where + BuildWhereBasedOnSearchText(searchText);

            return where;
        }


        private string BuildCommonReportSortOptions(string sortField, string sortDir)
        {
            string _sortOptions = (!string.IsNullOrEmpty(sortField)) ? sortField : " ComplaintId";
            _sortOptions = (!string.IsNullOrEmpty(sortField) && !string.IsNullOrEmpty(sortDir)) ? _sortOptions + " " + sortDir : _sortOptions + " ASC";

            return _sortOptions;
        }

        private List<ComplianceReportResult_Ext> BuildCommonReport(string where, string OrderBy, int pageSize, int pageNo)
        {
            DBFactory db;
            SqlDataReader rdr;
            List<ComplianceReportResult_Ext> data = null;

            try
            {
                db = new DBFactory("CCATDBEntities");
                rdr = db.ExecuteReader("sp_ReportSearch", new SqlParameter("@userId", UserId.ToString()), new SqlParameter("@where", where), new SqlParameter("@OrderBy", OrderBy), new SqlParameter("@pageSize", pageSize), new SqlParameter("@pageNo", pageNo));
                data = new List<ComplianceReportResult_Ext>();
                ComplianceReportResult_Ext record;
                while (rdr.Read())
                {
                    record = new ComplianceReportResult_Ext();

                    record.LastName = rdr["LastName"].ToString();
                    record.FirstName = rdr["FirstName"].ToString();
                    record.ComPlaintId = rdr["ComPlaintId"].ToString();
                    record.LastFourSSN = rdr["LastFourSSN"].ToString();
                    record.AccountNumber = rdr["Accountnumber"].ToString();

                    if (rdr["UpdatedByLastName"] != DBNull.Value)
                        record.UpdatedByLastName = rdr["UpdatedByLastName"].ToString();
                    if (rdr["UpdatedByFirstName"] != DBNull.Value)
                        record.UpdatedByFirstName = rdr["UpdatedByFirstName"].ToString();
                    if (rdr["UpdatedByLastName"] != DBNull.Value && rdr["UpdatedByFirstName"] != DBNull.Value)
                        record.UpdatedByFullName = rdr["UpdatedByLastName"].ToString() + " " + rdr["UpdatedByFirstName"].ToString();

                    if (rdr["AgencyId"] != DBNull.Value)
                        record.AgencyId = rdr["AgencyId"].ToString();

                    if (rdr["ComplaintIssue"] != DBNull.Value)
                        record.ComplaintIssue = rdr["ComplaintIssue"].ToString();
                    if (rdr["ComplaintDate"] != DBNull.Value)
                        record.ComplaintDate = Convert.ToDateTime(rdr["ComplaintDate"]);
                    if (rdr["ResolvedDate"] != DBNull.Value)
                        record.ResolvedDate = Convert.ToDateTime(rdr["ResolvedDate"]);
                    if (rdr["DateRequested"] != DBNull.Value)
                        record.DateRequested = Convert.ToDateTime(rdr["DateRequested"]);
                    if (rdr["DateSubmitted"] != DBNull.Value)
                        record.DateSubmitted = Convert.ToDateTime(rdr["DateSubmitted"]);
                    if (rdr["AgencyRequestDate"] != DBNull.Value)
                        record.AgencyRequestDate = Convert.ToDateTime(rdr["AgencyRequestDate"]);
                    if (rdr["OwnerResponseDate"] != DBNull.Value)
                        record.OwnerResponseDate = Convert.ToDateTime(rdr["OwnerResponseDate"]);
                    if (rdr["UpdatedDateTime"] != DBNull.Value)
                        record.UpdatedDateTime = Convert.ToDateTime(rdr["UpdatedDateTime"]);
                    if (rdr["ResponseTimeDays"] != DBNull.Value)
                        record.ResponseTimeDays = Convert.ToInt32(rdr["ResponseTimeDays"]);
                    if (rdr["TotalResponseTimeDays"] != DBNull.Value)
                        record.TotalResponseTimeDays = Convert.ToInt32(rdr["TotalResponseTimeDays"]);
                    if (!string.IsNullOrEmpty(rdr["AgentLastName"].ToString()))
                    {
                        record.AgentLastName = rdr["AgentLastName"].ToString();
                        record.AgentFullName = rdr["AgentLastName"].ToString() + " " + rdr["AgentFirstName"].ToString();
                    }
                    if (!string.IsNullOrEmpty(rdr["AgentFirstName"].ToString()))
                    {
                        record.AgentFirstName = rdr["AgentFirstName"].ToString();
                        record.AgentFullName = record.AgentFullName + " " + rdr["AgentFirstName"].ToString();
                    }
                    
                    if (rdr["count_"] != DBNull.Value)
                        record.count_ = Convert.ToInt32(rdr["count_"]);
                    if (rdr["rowNo"] != DBNull.Value)
                        record.rowNo = Convert.ToInt64(rdr["rowNo"]);

                    if (record.ComplaintDate.ToString() == "1/1/1900 12:00:00 AM")
                    {
                        record.ComplaintDate = null;
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

        #endregion
    }
}
