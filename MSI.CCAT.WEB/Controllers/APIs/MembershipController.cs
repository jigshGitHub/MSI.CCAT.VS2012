using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Data;
using MSI.CCAT.WEB.Models;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class MembershipController : ApiController
    {
        [HttpGet]
        public IEnumerable<UserModel> GetAllUsers()
        {
            try
            {
                IUnitOfWork uo = new UnitOfWork("CCATDBEntities");
                var data = from m in uo.Repository<aspnet_Membership>().GetAll()
                           from user in uo.Repository<aspnet_Users>().GetAll().Where(userRecord => userRecord.UserId == m.UserId)
                           select new UserModel(user.UserId);
                return data;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }
    }
}
