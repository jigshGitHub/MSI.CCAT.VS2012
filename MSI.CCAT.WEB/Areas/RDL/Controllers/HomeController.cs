using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

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



namespace MSI.CCAT.WEB.Areas.RDL.Controllers
{
    public class HomeController : BaseController
    {
        //
        // GET: /RDL/Home/

        public ActionResult Index(string Report)
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        public ActionResult ASPXView()
        {
            //ViewData["reportUrl"] = "../Reports/View/local/ClosingInventory/";
            //PopUpWindow("../Report.aspx", "Report");
            return JavaScript("alert('Some message')");
            
        }

       /* public ActionResult ASPXUserControl()
        {
            return View();
        }
        * */
        public static void PopUpWindow(string pTarget, string pName)
        {

            /*  Page p;
              StringBuilder strScript = new StringBuilder();

              strScript.Append("<script language=JavaScript>");
              strScript.Append("var " + pName + "=window.open('" + pTarget);
              strScript.Append("','WindowName','height=800,width=1100,toolbar=yes,");
              strScript.Append(" menubar=yes,resizable=yes,scrollbars=yes');");
              //    strScript.Append("if (window.focus) {" + pName + ".focus()};");
              strScript.Append("</script>");

              //var handler = HttpContext.Current.Handler as System.Web.Mvc.MvcHandler;
              var handler = (System.Web.Mvc.MvcHandler)System.Web.HttpContext.Current.Handler;
              p = (System.Web.UI.Page)handler;
              //Ok..I am going to sleep. I sent RDL files in email...


              //       p.RegisterStartupScript("startupScript", strScript.ToString());
              p.ClientScript.RegisterStartupScript(typeof(string), "startupScript", strScript.ToString());
              */
        }

        #region [[ Additional Pages for SSRS reports ]]
        
        public ActionResult Policies()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult Reports()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult NewFunctionality()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult NewFeature()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult NewReportFeature()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult NewRptFeature()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }
        
        public ActionResult BrandNewFeature()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }

        public ActionResult DocumentsTracking()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }

        public ActionResult DocumentsTraining()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }

        public ActionResult DocumentMaintenance()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }

        public ActionResult TrainingMaintenance()
        {
            Session["UserID"] = UserId.ToString();
            Session["UserRole"] = UserRoles.First();
            Session["UserName"] = UserName;
            Session["RoleEntityValue"] = RoleEntityValue;
            //Now display the view            
            return View();
        }

        #endregion

    }
}
