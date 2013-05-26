using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Business.BusinessModels;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.Business
{
    public class AssessmentBus
    {
        public IEnumerable<AssessmentResponse> GetResponse(Guid userId, int moduleId)
        {
            QuestionBankRepository questionBankRepository;
            QuestionResponseRepository responseRepository;
            IEnumerable<AssessmentResponse> assessmentResponses = null;
            IEnumerable<Tbl_QuestionBank> questions = null;
            try
            {
                questionBankRepository = new QuestionBankRepository();
                responseRepository = new QuestionResponseRepository();

                questions = from questionBank in questionBankRepository.GetAll().Where(q => q.IsActive == true && q.ModuleId == moduleId)
                            select questionBank;

                assessmentResponses = from questionBank in questions
                                      from questionResponse in responseRepository.GetAll().Where(r => r.QuestionId == questionBank.Id && r.CreatedBy == userId)
                                      select new AssessmentResponse() { ModuleId = moduleId, Question = questionBank.Text, Response = questionResponse.Value, ResponseId = questionResponse.Id, SerialNumber = questionBank.SrNo, UserId = userId };

                if (assessmentResponses.Count() == 0)
                {
                    CreateResponse(userId, questions);

                    assessmentResponses = from questionBank in questions
                                          from questionResponse in responseRepository.GetAll().Where(r => r.QuestionId == questionBank.Id && r.CreatedBy == userId)
                                          select new AssessmentResponse() { ModuleId = moduleId, Question = questionBank.Text, Response = questionResponse.Value, ResponseId = questionResponse.Id, SerialNumber = questionBank.SrNo, UserId = userId };

                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return assessmentResponses;
        }

        private void CreateResponse(Guid userId, IEnumerable<Tbl_QuestionBank> defaultQuestions)
        {
            QuestionResponseRepository responseRepository;
            Tbl_QuestionResponse response;
            try
            {
                responseRepository = new QuestionResponseRepository();
                foreach (Tbl_QuestionBank question in defaultQuestions)
                {
                    response = new Tbl_QuestionResponse();
                    response.QuestionId = question.Id;
                    response.CreatedBy = userId;
                    response.CreatedOn = DateTime.Now;
                    responseRepository.Add(response);
                }
            }
            catch (Exception ex)
            {
            }
        }
    }


}
