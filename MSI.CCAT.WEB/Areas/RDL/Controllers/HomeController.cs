using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace MSI.CCAT.WEB.Areas.RDL.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /RDL/Home/

        public ActionResult Index(string Report)
        {
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
        public ActionResult Policies()
        {
            return View();
        }
        public ActionResult Reports()
        {
            return View();
        }
        public ActionResult NewFunctinality1()
        {
            return View();
        }
        public ActionResult NewFunctinality2()
        {
            return View();
        }
        public ActionResult NewFunctinality3()
        {
            return View();
        }
        public ActionResult NewFunctinality4()
        {
            return View();
        }
        public ActionResult NewFunctinality5()
        {
            return View();
        }
    }
}
