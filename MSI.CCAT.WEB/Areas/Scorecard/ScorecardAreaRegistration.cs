using System.Web.Mvc;

namespace MSI.CCAT.WEB.Areas.Scorecard
{
    public class ScorecardAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Scorecard";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Scorecard_default",
                "Scorecard/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                new string[] { "MSI.CCAT.WEB.Areas.Scorecard.Controllers" }
            );
        }
    }
}
