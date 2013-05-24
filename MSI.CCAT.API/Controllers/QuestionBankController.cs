using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Data.Repositories;
namespace MSI.CCAT.API.Controllers
{
    public class QuestionBankController : ApiController
    {
        public IQueryable<Tbl_QuestionBank> Get(int moduleId)
        {
            QuestionBankRepository repository = new QuestionBankRepository();

            IQueryable<Tbl_QuestionBank> data = null;
            try
            {
                data = repository.GetAll().Where(r => r.moduleId == moduleId && r.IsActive == true).AsQueryable<Tbl_QuestionBank>();
            }
            catch (Exception ex)
            {
                throw new Exception("MSI.CCAT.API.Controller.QuestionBankController:" + ex.Message);
            }
            return data;
        }
    }
}
