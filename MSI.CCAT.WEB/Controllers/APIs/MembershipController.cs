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
    public class MembershipController : BaseAPIController
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
        [HttpGet]
        public IEnumerable<LookUp> GetManagers(string roleEntityValue = "")
        {
            roleEntityValue = (string.IsNullOrEmpty(roleEntityValue)) ? RoleEntityValue : roleEntityValue;
            UnitOfWork uo = new UnitOfWork("CCATDBEntities");
            IEnumerable<LookUp> lookupData = from manager in uo.Repository<vw_aspnet_membership>().GetAll()
                                             where manager.RoleName == "AgencyManager" && manager.RoleEntityValue == roleEntityValue
                                             orderby manager.LastName ascending
                                             select new LookUp(manager.LastName + " " + manager.FirstName, manager.UserId.ToString());
            return lookupData;
        }

        [HttpGet]
        public IEnumerable<LookUp> GetCollectorsByManagers(string managerIds, string roleEntityValue = "")
        {
            roleEntityValue = (string.IsNullOrEmpty(roleEntityValue)) ? RoleEntityValue : roleEntityValue;

            IEnumerable<LookUp> lookupData = null;
            if (!string.IsNullOrEmpty(managerIds))
            {
                var managers = managerIds.Split(new char[] { ',' });
                UnitOfWork uo = new UnitOfWork("CCATDBEntities");
                var data = from collector in uo.Repository<vw_aspnet_membership>().GetAll()
                           where collector.RoleName == "AgencyCollector" && collector.RoleEntityValue == roleEntityValue 
                           orderby collector.LastName ascending
                           select new { LastName = collector.LastName, FirstName = collector.FirstName, UserId = collector.UserId.ToString(), ManagerId = collector.ManagerId.ToString() };
                lookupData = (from r in data join filteredManager in managers on r.ManagerId equals filteredManager select new LookUp(r.LastName + " " + r.FirstName, r.UserId.ToString()));

            }
            return lookupData;
        }
    }
}
