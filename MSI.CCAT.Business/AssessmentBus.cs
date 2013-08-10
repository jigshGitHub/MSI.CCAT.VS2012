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
            QuestionBus questionBus;
            ResponseBus responseBus;
            IEnumerable<AssessmentResponse> assessmentResponses = null;
            IEnumerable<Tbl_QuestionBank> questions = null;
            IEnumerable<Tbl_QuestionResponse> responses = null;
            try
            {
                questionBus = new QuestionBus();
                responseBus = new ResponseBus();

                questions = questionBus.GetQuestions(moduleId);
                responses= responseBus.GetResponses(userId,moduleId);

                if (responses.Count() == 0)
                    responses = CreateDefaultResponses(userId, questions);

                //assessmentResponses = from questionBank in questions
                //                      from questionResponse in responses.Where(r => r.QuestionId == questionBank.Id && r.CreatedBy == userId)
                //                      select new AssessmentResponse() { QuestionId = questionBank.Id, ModuleId = moduleId, Question = questionBank.Text, QuestionTooltip = questionBank.ToolTipText, Response = questionResponse.Value, ResponseId = questionResponse.Id, SerialNumber = questionBank.SrNo, UserId = userId }; 
                assessmentResponses = from questionBank in questions join 
                                      questionResponse in responses on questionBank.Id equals questionResponse.QuestionId
                                      where questionResponse.CreatedBy == userId
                                      select new AssessmentResponse() { QuestionId = questionBank.Id, ModuleId = moduleId, Question = questionBank.Text, QuestionTooltip = questionBank.ToolTipText, Response = questionResponse.Value, ResponseId = questionResponse.Id, SerialNumber = questionBank.SrNo, UserId = userId };                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return assessmentResponses;
        }

        public IEnumerable<AssessmentResponse> GetResponseWithDeficiencies(Guid userId, int moduleId)
        {
            QuestionBus questionBus;
            ResponseBus responseBus;
            IEnumerable<AssessmentResponse> assessmentResponses = null;
            IEnumerable<Tbl_QuestionBank> questions = null;
            IEnumerable<Tbl_QuestionResponse> responses = null;
            IEnumerable<Tbl_QuestionDeficient> deficiences = null;
            try
            {
                questionBus = new QuestionBus();
                responseBus = new ResponseBus();

                questions = questionBus.GetQuestions(moduleId);
                responses = responseBus.GetResponses(userId, moduleId);
                deficiences = responseBus.GetDeficiences();

                if (responses.Count() == 0)
                    responses = CreateDefaultResponses(userId, questions);

                assessmentResponses = from questionBank in questions
                                      join questionResponse in responses on questionBank.Id equals questionResponse.QuestionId
                                      join questionDeficient in deficiences on questionResponse.Value equals questionDeficient.UserResponseValue
                                      where questionResponse.CreatedBy == userId  && questionDeficient.IsDeficient == true
                                      select new AssessmentResponse() { QuestionId = questionBank.Id, ModuleId = moduleId, Question = questionBank.Text, QuestionTooltip = questionBank.ToolTipText, Response = questionResponse.Value, ResponseId = questionResponse.Id, SerialNumber = questionBank.SrNo, UserId = userId, IsDeficient = questionDeficient .IsDeficient.Value};

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return assessmentResponses;
        }

        private IEnumerable<Tbl_QuestionResponse> CreateDefaultResponses(Guid userId, IEnumerable<Tbl_QuestionBank> defaultQuestions)
        {
            ResponseBus responseBus;
            List<Tbl_QuestionResponse> responses = null ;
            try
            {
                responseBus = new ResponseBus();
                responses = new List<Tbl_QuestionResponse>();
                foreach (Tbl_QuestionBank question in defaultQuestions)
                    responses.Add(responseBus.CreateResponse(userId, question.Id));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return responses.AsEnumerable<Tbl_QuestionResponse>();
        }

        public AssessmentResponse UpdateResponse(AssessmentResponse assessmentResponse)
        {
            ResponseBus responseBus;
            Tbl_QuestionResponse response = null;
            try
            {
                responseBus = new ResponseBus();
                response = responseBus.UpdateResponse(assessmentResponse.UserId, assessmentResponse.Response, assessmentResponse.ResponseId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return assessmentResponse;
        }
    }


}
