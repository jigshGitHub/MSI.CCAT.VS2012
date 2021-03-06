﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Business;
using MSI.CCAT.Business.BusinessModels;
namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class AssessmentController : ApiController
    {
        [HttpGet()]
        public IEnumerable<AssessmentResponse> Get(int moduleId, string userId)
        {
            AssessmentBus business;
            IEnumerable<AssessmentResponse> data = null;

            try
            {
                business = new AssessmentBus();
                data = business.GetResponse(Guid.Parse(userId), moduleId);
            }
            catch (Exception ex)
            {
                throw new Exception("MSI.CCAT.API.Controller.AssessmentController:" + ex.Message);
            }
            return data;
        }

        [HttpGet()]
        [ActionName("GetDeficients")]
        public IEnumerable<AssessmentResponse> GetDeficients(int moduleId, string userId)
        {
            AssessmentBus business;
            IEnumerable<AssessmentResponse> data = null;

            try
            {
                business = new AssessmentBus();
                data = business.GetResponseWithDeficiencies(Guid.Parse(userId), moduleId);
            }
            catch (Exception ex)
            {
                throw new Exception("MSI.CCAT.API.Controller.AssessmentController:" + ex.Message);
            }
            return data;
        }

        public void Post(AssessmentResponse response)
        {
            AssessmentBus business;

            try
            {
                business = new AssessmentBus();
                business.UpdateResponse(response);
            }
            catch (Exception ex)
            {
                throw new Exception("MSI.CCAT.API.Controller.AssessmentController:" + ex.Message);
            }
        }
    }
}
