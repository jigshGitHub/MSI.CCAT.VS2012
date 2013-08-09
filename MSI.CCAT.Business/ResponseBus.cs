using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;

namespace MSI.CCAT.Business
{
    public class ResponseBus
    {
        public IEnumerable<Tbl_QuestionResponse> GetResponses(Guid userId, int moduleId)
        {
            //QuestionResponseRepository repsonseRepository;
            IEnumerable<Tbl_QuestionResponse> responses = null;
            try
            {
                //repsonseRepository = new QuestionResponseRepository();
                IUnitOfWork uo = new UnitOfWork("CCATDBEntities");
                responses = from response in uo.Repository<Tbl_QuestionResponse>().GetAll().Where(r => r.CreatedBy == userId)
                            from question in uo.Repository<Tbl_QuestionBank>().GetAll().Where(r=> r.Id == response.QuestionId && r.ModuleId == moduleId)
                            select response;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return responses;
        }

        public IEnumerable<Tbl_QuestionDeficient> GetDeficiences()
        {
            IEnumerable<Tbl_QuestionDeficient> deficiences = null;
            try
            {
                IUnitOfWork uo = new UnitOfWork("CCATDBEntities");
                deficiences = from deficient in uo.Repository<Tbl_QuestionDeficient>().GetAll()
                            select deficient;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return deficiences;
        }

        public Tbl_QuestionResponse CreateResponse(Guid userId, int questionId)
        {
            //QuestionResponseRepository responseRepository;
            Tbl_QuestionResponse response;
            try
            {
                //responseRepository = new QuestionResponseRepository();
                IUnitOfWork uo = new UnitOfWork("CCATDBEntities");

                response = new Tbl_QuestionResponse();
                response.QuestionId = questionId;
                response.CreatedBy = userId;
                response.CreatedOn = DateTime.Now;
                uo.Repository<Tbl_QuestionResponse>().Add(response);
                uo.Save();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return response;
        }

        public Tbl_QuestionResponse UpdateResponse(Guid userId, string value, int responseId)
        {
            //QuestionResponseRepository responseRepository;
            Tbl_QuestionResponse response = null;
            try
            {
                //responseRepository = new QuestionResponseRepository();
                IUnitOfWork uo = new UnitOfWork("CCATDBEntities");
                response = uo.Repository<Tbl_QuestionResponse>().GetById(responseId);
                if (response != null)
                {
                    response.Value = value;
                    response.UpdatedBy = userId;
                    response.UpdatedOn = DateTime.Now;
                    uo.Repository<Tbl_QuestionResponse>().Update(response);
                    uo.Save();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return response;
        }
    }
}
