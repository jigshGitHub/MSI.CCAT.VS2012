﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Data.Repositories;

namespace MSI.CCAT.Business
{
    public class QuestionBus
    {
        public IEnumerable<Tbl_QuestionBank> GetQuestions(int moduleId)
        {
            QuestionBankRepository questionBankRepository;
            IEnumerable<Tbl_QuestionBank> questions = null;
            try
            {
                questionBankRepository = new QuestionBankRepository();
                questions = from questionBank in questionBankRepository.GetAll().Where(q => q.IsActive == true && q.ModuleId == moduleId)
                            select questionBank;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return questions;
        }
    }
}