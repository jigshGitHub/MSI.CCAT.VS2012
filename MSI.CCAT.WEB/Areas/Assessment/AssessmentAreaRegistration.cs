using System.Web.Mvc;

namespace MSI.CCAT.WEB.Areas.Assessment
{
    public class AssessmentAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Assessment";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Assessment_default",
                "Assessment/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                new string[]{"MSI.CCAT.WEB.Areas.Assessment.Controllers"}
            );
        }
    }
}
