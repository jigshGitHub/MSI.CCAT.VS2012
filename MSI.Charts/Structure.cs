using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;

namespace MSI.Charts
{
    public static class ChartHelper
    {


    }

    public interface IChart
    {
        void LoadChart(string userId);
        string CreateCategories();
        string CreateDataSets();
        void CreateChart();
    }

    public enum ChartID
    {
        AssessmentResults,
    }

    public enum ChartTypes
    {
        Chart,
        PieChart,
        BarChart
    }

    public enum ChartSubType
    {

    }

    public class Chart : IChart
    {
        public string Caption { get; set; }
        public string NumberSuffix { get; set; }
        public string BGColor { get; set; }
        public string BGAlpha { get; set; }
        public string CanvasBGColor { get; set; }
        public string CanvasBGAlpha { get; set; }
        public string XaxisName { get; set; }
        public string YaxisName { get; set; }
        public string DrillChartIds { get; set; }
        public string DrillBy { get; set; }
        public List<Category> Categories { get; set; }
        public List<ChartDataSet> DataSetCollection { get; set; }
        public bool DrillOverride { get; set; }

        public string SWF { get; set; }
        public string ChartXML { get; set; }
        public ChartID Id { get; set; }
        public string Hight { get; set; }
        public string Width { get; set; }
        public string PieRadius { get; set; }
        public string showLabels { get; set; }
        public string enableRotation { get; set; }
        public string showLegend { get; set; }
        public string[] SearchParameters { get; set; }
        public Chart()
        {
            this.Categories = new List<Category>();
            this.DataSetCollection = new List<ChartDataSet>();
            this.DrillOverride = true;
        }


        public void LoadChart(string userName)
        {
            try
            {
                switch ((ChartID)Enum.Parse(typeof(ChartID), this.Id.ToString(), true))
                {
                    case ChartID.AssessmentResults:
                        IUnitOfWork uo = new UnitOfWork("CCATDBEntities");
                        var data = from response in uo.Repository<Tbl_QuestionResponse>().GetAll().Where(record => record.CreatedBy == new Guid(this.SearchParameters.First()))
                                   join question in uo.Repository<Tbl_QuestionBank>().GetAll() on response.QuestionId equals question.Id
                                   join _module in uo.Repository<Tbl_QuestionModule>().GetAll() on question.ModuleId equals _module.Id
                                   group response by new { _module.Id, _module.Name, _module.IndustryAverage, _module.QuetionQuantity }
                                       into grp
                                       select new { grp.Key.Id, value = grp.Sum(r => (r.Value == "N/A") ? 0 : Convert.ToDecimal(r.Value)), indAvg = grp.Key.IndustryAverage, name = grp.Key.Name, totalQuestions = grp.Key.QuetionQuantity };

                        this.DataSetCollection.Add(new ChartDataSet { Color = "0000FF", SeriesName = userName });
                        this.DataSetCollection.Add(new ChartDataSet { Color = "8A4B08", SeriesName = "Industry Average" });

                        decimal percentValue;
                        foreach (var value in data)
                        {
                            this.Categories.Add(new Category { Label = value.name });

                            percentValue = (value.value * 20) / value.totalQuestions.Value;
                            this.DataSetCollection[0].SetsCollection.Add(new SetValue { Label = value.name, Value = Math.Round(percentValue, 2).ToString(), Link = "/#/Assessment/Home/DeficientQuestions?moduleId=" + value.Id.ToString() });
                            this.DataSetCollection[1].SetsCollection.Add(new SetValue { Label = value.name, Value = value.indAvg.ToString().Substring(0, value.indAvg.ToString().Length - 1) });

                        }
                        //var data = from response in uo.Repository<Tbl_QuestionResponse>().GetAll().Where(record => record.CreatedBy == new Guid(this.SearchParameters.First()) && record.Value != null)
                        //           join question in uo.Repository<Tbl_QuestionBank>().GetAll() on response.QuestionId equals question.Id
                        //           join _module in uo.Repository<Tbl_QuestionModule>().GetAll() on question.ModuleId equals _module.Id
                        //           group response by new { _module.Id, _module.Name, _module.IndustryAverage, _module.QuetionQuantity }
                        //               into grp
                        //               select new { grp.Key.Id, value = grp.Sum(r => (r.Value == "N/A") ? 0 : Convert.ToDecimal(r.Value)), indAvg = grp.Key.IndustryAverage, name = grp.Key.Name, totalQuestions = grp.Key.QuetionQuantity };

                        //foreach (Tbl_QuestionModule module in uo.Repository<Tbl_QuestionModule>().GetAll())
                        //{
                        //    this.Categories.Add(new Category { Label = module.Name });
                        //}
                        //foreach (Category category in Categories)
                        //{
                        //    var value = data.Where(r => r.name == category.Label).SingleOrDefault();
                        //    if (value != null)
                        //    {
                        //        percentValue = (value.value * 20) / value.totalQuestions.Value;
                        //        this.DataSetCollection[0].SetsCollection.Add(new SetValue { Label = category.Label, Value = Math.Round(percentValue, 2).ToString(), Link = "/#/Assessment/Home/DeficientQuestions?moduleId=" + value.Id.ToString() });
                        //        this.DataSetCollection[1].SetsCollection.Add(new SetValue { Label = category.Label, Value = value.indAvg.ToString().Substring(0, value.indAvg.ToString().Length - 1) });
                        //    }
                        //    else
                        //    {
                        //        this.DataSetCollection[0].SetsCollection.Add(new SetValue { Label = category.Label, Value = "0", Link = "/#/Assessment/Home/DeficientQuestions?moduleId=" + value.Id.ToString() });
                        //        this.DataSetCollection[1].SetsCollection.Add(new SetValue { Label = category.Label, Value = value.indAvg.ToString().Substring(0, value.indAvg.ToString().Length - 1) });
                        //    }
                        //}
                        //this.Categories.Add(new Category { Label = DateTime.Now.AddMonths(-2).ToString("MMM") });
                        //this.Categories.Add(new Category { Label = DateTime.Now.AddMonths(-1).ToString("MMM") });
                        //this.Categories.Add(new Category { Label = DateTime.Now.AddMonths(0).ToString("MMM") });

                        //chartParams = new List<ChartParameter>();
                        //chartParams.Add(new ChartParameter { Value = "jshah", Color = "2908AD" });
                        //chartParams.Add(new ChartParameter { Value = "Industry Average", Color = "B54908" });

                        //values = "30,20,35,30,45,50,40,45,80,50,30,50,80,45".Split(new char[] { ',' });
                        //index = 0;
                        //foreach (ChartParameter parameter in chartParams)
                        //{
                        //    try
                        //    {
                        //        this.DataSetCollection.Add(new ChartDataSet { Color = parameter.Color, SeriesName = parameter.Value });

                        //        foreach (Category category in this.Categories)
                        //        {
                        //            lastDs = this.DataSetCollection.Last();
                        //            lastDs.SetsCollection.Add(new SetValue { Label = category.Label });
                        //        }

                        //        do
                        //        {
                        //            foreach (SetValue set in lastDs.SetsCollection)
                        //            {
                        //                set.Value = values[index].ToString();
                        //                index++;
                        //            }
                        //        } while (index % 7 != 0);
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        throw new Exception("Error in ChartID.MediaPaidByCheck:" + ex.Message);
                        //    }
                        //    //}
                        //}
                        break;
                    default:
                        break;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string CreateCategories()
        {
            StringBuilder categoriesXML = null;
            try
            {
                categoriesXML = new StringBuilder("<categories>");
                foreach (Category category in this.Categories)
                {
                    categoriesXML.Append("<category");
                    categoriesXML.Append((!(string.IsNullOrEmpty(category.Label)) ? " label='" + category.Label + "'" : ""));
                    categoriesXML.Append("/>");
                }
                categoriesXML.Append("</categories>");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return categoriesXML.ToString();
        }

        public string CreateDataSets()
        {
            StringBuilder datasetXML = null;
            try
            {
                datasetXML = new StringBuilder();

                foreach (ChartDataSet ds in this.DataSetCollection)
                {
                    datasetXML.Append("<dataset" + (!(string.IsNullOrEmpty(ds.SeriesName)) ? " seriesName='" + ds.SeriesName + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(ds.Color)) ? " color='" + ds.Color + "'" : ""));
                    datasetXML.Append(">");

                    foreach (SetValue set in ds.SetsCollection)
                    {
                        datasetXML.Append("<set");
                        datasetXML.Append((!(string.IsNullOrEmpty(set.Value)) ? " value='" + set.Value + "'" : ""));
                        datasetXML.Append((!(string.IsNullOrEmpty(set.Color)) ? " color='" + set.Color + "'" : ""));
                        datasetXML.Append((!(string.IsNullOrEmpty(set.Link)) ? " link='" + set.Link + "'" : ""));
                        datasetXML.Append("/>");
                    }
                    datasetXML.Append("</dataset>");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return datasetXML.ToString();
        }

        public void CreateChart()
        {
            StringBuilder chartXML = null;
            try
            {
                chartXML = new StringBuilder("<chart" + (!(string.IsNullOrEmpty(this.Caption)) ? " caption='" + this.Caption + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.BGColor)) ? " bgColor='" + this.BGColor + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.BGAlpha)) ? " bgAlpha='" + this.BGAlpha + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.CanvasBGColor)) ? " canvasBgColor='" + this.CanvasBGColor + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.CanvasBGAlpha)) ? " canvasBgAlpha='" + this.CanvasBGAlpha + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.XaxisName)) ? " xAxisName='" + this.XaxisName + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.YaxisName)) ? " yAxisName='" + this.YaxisName + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.NumberSuffix)) ? " numberSuffix='" + this.NumberSuffix + "'" : ""));
                chartXML.Append(">");

                chartXML.Append(CreateCategories());

                chartXML.Append(CreateDataSets());

                chartXML.Append("</chart>");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            ChartXML = chartXML.ToString();
        }

    }

    public class BarChart : Chart
    {
        public List<SetValue> SetsCollection;

        public BarChart()
            : base()
        {
            SetsCollection = new List<SetValue>();
        }

        public new void LoadChart()
        {
            try
            {

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public new string CreateDataSets()
        {
            StringBuilder datasetXML = null;
            try
            {
                datasetXML = new StringBuilder();

                foreach (SetValue set in SetsCollection)
                {
                    datasetXML.Append("<set");
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Label)) ? " label='" + set.Label + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Value)) ? " value='" + set.Value + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Color)) ? " color='" + set.Color + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Link)) ? " link='" + set.Link + "'" : ""));
                    datasetXML.Append("/>");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return datasetXML.ToString();
        }

        public new void CreateChart()
        {
            StringBuilder chartXML = null;
            try
            {
                chartXML = new StringBuilder("<chart" + (!(string.IsNullOrEmpty(this.Caption)) ? " caption='" + this.Caption + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.BGColor)) ? " bgColor='" + this.BGColor + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.BGAlpha)) ? " bgAlpha='" + this.BGAlpha + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.CanvasBGColor)) ? " canvasBgColor='" + this.CanvasBGColor + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.CanvasBGAlpha)) ? " canvasBgAlpha='" + this.CanvasBGAlpha + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.XaxisName)) ? " xAxisName='" + this.XaxisName + "'" : ""));
                chartXML.Append((!(string.IsNullOrEmpty(this.YaxisName)) ? " yAxisName='" + this.YaxisName + "'" : ""));
                chartXML.Append(">");

                chartXML.Append(CreateDataSets());

                chartXML.Append("</chart>");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            ChartXML = chartXML.ToString();
        }
    }

    public class PieChart : BarChart
    {
        public List<SetValue> SetsCollection;

        public PieChart()
            : base()
        {
            SetsCollection = new List<SetValue>();
        }
        public new string CreateDataSets()
        {
            StringBuilder datasetXML = null;
            try
            {
                datasetXML = new StringBuilder();

                foreach (SetValue set in SetsCollection)
                {
                    datasetXML.Append("<set");
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Label)) ? " label='" + set.Label + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Value)) ? " value='" + set.Value + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Color)) ? " color='" + set.Color + "'" : ""));
                    datasetXML.Append((!(string.IsNullOrEmpty(set.Link)) ? " link='" + set.Link + "'" : ""));
                    datasetXML.Append("/>");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return datasetXML.ToString();
        }

        public new void LoadChart()
        {
            try
            {
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    public class Category
    {
        public string Label { get; set; }
        public Category()
        {
        }
    }

    public class ChartDataSet
    {
        public string SeriesName { get; set; }
        public string Color { get; set; }
        public List<SetValue> SetsCollection { get; set; }

        public ChartDataSet()
        {
            this.SetsCollection = new List<SetValue>();
        }

    }

    public class SetValue
    {
        public string Value { get; set; }
        public string Link { get; set; }
        public string Color { get; set; }
        public string Label { get; set; }
    }

    public class ChartParameter
    {
        public string Color { get; set; }
        public string Value { get; set; }
    }
}
