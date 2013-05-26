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
        public IEnumerable<Tbl_QuestionResponse> GetResponses(Guid userId)
        {
            QuestionResponseRepository repsonseRepository;
            IEnumerable<Tbl_QuestionResponse> responses = null;
            try
            {
                repsonseRepository = new QuestionResponseRepository();
                responses = from response in repsonseRepository.GetAll().Where(r => r.CreatedBy == userId)
                            select response;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return responses;
        }

        public Tbl_QuestionResponse CreateResponse(Guid userId, int questionId)
        {
            QuestionResponseRepository responseRepository;
            Tbl_QuestionResponse response;
            try
            {
                responseRepository = new QuestionResponseRepository();
                response = new Tbl_QuestionResponse();
                response.QuestionId = questionId;
                response.CreatedBy = userId;
                response.CreatedOn = DateTime.Now;
                responseRepository.Add(response);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return response;
        }

        public Tbl_QuestionResponse UpdateResponse(Guid userId, string value, int responseId)
        {
            QuestionResponseRepository responseRepository;
            Tbl_QuestionResponse response = null;
            try
            {
                responseRepository = new QuestionResponseRepository();
                response = responseRepository.GetById(responseId);
                if (response != null)
                {
                    response.Value = value;
                    response.UpdatedBy = userId;
                    response.UpdatedOn = DateTime.Now;
                    responseRepository.Update(response);
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
