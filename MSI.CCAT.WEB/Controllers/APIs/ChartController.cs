using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.Charts;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class ChartController : ApiController
    {
        [HttpGet]
        public IChart Get(string strChartId, string strDrillBy, string strUserName, string strSearchParameter)
        {
            ChartID idSelected;
            IChart chartToLoad = null;
            TBL_CHART dbChart = null;
            IUnitOfWork uo = new UnitOfWork("CCATDBEntities");

            idSelected = (ChartID)Enum.Parse(typeof(ChartID), strChartId, true);

                
            dbChart = uo.Repository<TBL_CHART>().GetAll().Where(c => c.ChartID == strChartId && c.IsActive == true).SingleOrDefault();


            if (dbChart.TypeOfChart == "Chart")
            {
                chartToLoad = new Chart() { SearchParameters = new string[] { strSearchParameter}, BGAlpha = dbChart.BgAlpha, BGColor = dbChart.BgColor, CanvasBGAlpha = dbChart.CanvasBgAlpha, CanvasBGColor = dbChart.CanvasBgColor, Caption = dbChart.Caption, SWF = dbChart.SWFile, NumberSuffix = dbChart.NumberSuffix, PieRadius = dbChart.PieRadius, showLabels = dbChart.ShowLabels, showLegend = dbChart.ShowLegend, XaxisName = dbChart.XaxisName, YaxisName = dbChart.YaxisName, Id = idSelected, enableRotation = dbChart.EnableRotation, DrillChartIds = (string.IsNullOrEmpty(dbChart.DrillLevelChartIDs)) ? "" : dbChart.DrillLevelChartIDs, DrillOverride = false, DrillBy = (string.IsNullOrEmpty(strDrillBy)) ? "" : strDrillBy };
                chartToLoad.LoadChart(strUserName);
                chartToLoad.CreateChart();
            }
            else if (dbChart.TypeOfChart == "PieChart")
            {
                chartToLoad = new PieChart() { BGAlpha = dbChart.BgAlpha, BGColor = dbChart.BgColor, CanvasBGAlpha = dbChart.CanvasBgAlpha, CanvasBGColor = dbChart.CanvasBgColor, Caption = dbChart.Caption, SWF = dbChart.SWFile, NumberSuffix = dbChart.NumberSuffix, PieRadius = dbChart.PieRadius, showLabels = dbChart.ShowLabels, showLegend = dbChart.ShowLegend, XaxisName = dbChart.XaxisName, YaxisName = dbChart.YaxisName, Id = idSelected, enableRotation = dbChart.EnableRotation, DrillChartIds = (string.IsNullOrEmpty(dbChart.DrillLevelChartIDs)) ? "" : dbChart.DrillLevelChartIDs, DrillOverride = false, DrillBy = (string.IsNullOrEmpty(strDrillBy)) ? "" : strDrillBy };
                ((PieChart)chartToLoad).LoadChart();
                ((PieChart)chartToLoad).CreateChart();
            }
            else if (dbChart.TypeOfChart == "BarChart")
            {
                chartToLoad = new BarChart() { BGAlpha = dbChart.BgAlpha, BGColor = dbChart.BgColor, CanvasBGAlpha = dbChart.CanvasBgAlpha, CanvasBGColor = dbChart.CanvasBgColor, Caption = dbChart.Caption, SWF = dbChart.SWFile, NumberSuffix = dbChart.NumberSuffix, PieRadius = dbChart.PieRadius, showLabels = dbChart.ShowLabels, showLegend = dbChart.ShowLegend, XaxisName = dbChart.XaxisName, YaxisName = dbChart.YaxisName, Id = idSelected, enableRotation = dbChart.EnableRotation, DrillChartIds = (string.IsNullOrEmpty(dbChart.DrillLevelChartIDs)) ? "" : dbChart.DrillLevelChartIDs, DrillOverride = false, DrillBy = (string.IsNullOrEmpty(strDrillBy)) ? "" : strDrillBy };
                ((BarChart)chartToLoad).LoadChart();
                ((BarChart)chartToLoad).CreateChart();
            }
            return chartToLoad;
        }
    }
}
