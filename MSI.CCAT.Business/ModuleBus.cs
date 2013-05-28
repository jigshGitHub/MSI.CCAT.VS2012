using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Data.Repositories;
namespace MSI.CCAT.Business
{
    public class ModuleBus
    {
        public IEnumerable<Tbl_QuestionModule> GetModules()
        {
            IEnumerable<Tbl_QuestionModule> modules = null;
            QuestionModuleRepository moduleRepository;

            try
            {
                moduleRepository = new QuestionModuleRepository();
                modules = moduleRepository.GetAll().Where(r => r.IsActive == true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return modules;
        }

        public Tbl_QuestionModule GetModuleDetails(int moduleId)
        {
            Tbl_QuestionModule module  = null;
            QuestionModuleRepository moduleRepository;

            try
            {
                moduleRepository = new QuestionModuleRepository();
                module = moduleRepository.GetById(moduleId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return module;
        }
    }
}
