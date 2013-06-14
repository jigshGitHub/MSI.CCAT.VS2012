using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MSI.CCAT.WEB.Controllers;
namespace MSI.CCAT.WEB.Areas.Scorecard.Controllers
{
    public class HomeController : BaseController
    {
        //
        // GET: /Scorecard/Home/

        public ActionResult Index()
        {
            return PartialView();
        }

    }
}
