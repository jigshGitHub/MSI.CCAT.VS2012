using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MSI.CCAT.WEB.Controllers;
namespace MSI.CCAT.WEB.Areas.Assessment.Controllers
{
    public class HomeController : BaseController
    {
        //
        // GET: /Assessment/Home/

        public ActionResult Index(int? moduleId, bool? onlyDeficient)
        {
            ViewBag.ModuleId = (moduleId.HasValue) ? moduleId.Value.ToString() : "1";
            ViewBag.OnlyDeficient = (onlyDeficient.HasValue) ? onlyDeficient.Value : false;
            return PartialView();
        }
    }
}
