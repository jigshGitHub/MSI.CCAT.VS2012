using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Business;

namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class QuestionModuleController : ApiController
    {
        public IEnumerable<Tbl_QuestionModule> Get()
        {
            IEnumerable<Tbl_QuestionModule> modules = null;
            ModuleBus moduleBus;

            try
            {
                moduleBus = new ModuleBus();
                modules = moduleBus.GetModules();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return modules;
        }

        [HttpGet]
        public Tbl_QuestionModule Details(int moduleId)
        {
            Tbl_QuestionModule module = null;
            ModuleBus moduleBus;

            try
            {
                moduleBus = new ModuleBus();
                module = moduleBus.GetModuleDetails(moduleId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return module;
        }
    }
}
