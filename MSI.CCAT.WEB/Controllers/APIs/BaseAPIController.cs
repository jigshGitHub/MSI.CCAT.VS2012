using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MSI.CCAT.Data.Models;
using MSI.CCAT.WEB.Models;
using MSI.CCAT.Data.Repositories;

namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class BaseAPIController : ApiController
    {
        private Guid userId;
        private string userName;
        private string roleEntityValue;

        protected Guid UserId { get { return userId; } }
        protected string UserName { get { return userName; } }
        protected string RoleEntityValue { get { return roleEntityValue; } }

        public BaseAPIController()
        {
            userId = (Guid)Membership.GetUser(System.Web.HttpContext.Current.User.Identity.Name).ProviderUserKey;
            userName = System.Web.HttpContext.Current.User.Identity.Name;
            roleEntityValue = new AccountProfile(UserName).RoleEntityValue;
        }
    }
}