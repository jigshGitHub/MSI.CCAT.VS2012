using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

using MSI.CCAT.WEB.Controllers;
namespace MSI.CCAT.WEB.Areas.Dashboard.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Overview()
        {
           return PartialView();
        }
    }
}
