using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Repositories;
using MSI.CCAT.Data.Models;

namespace MSI.CCAT.Business
{
    public class AccountBus
    {
        public static UserRole GetUserRole(string userId)
        {
            UnitOfWork uo;

            try
            {
                uo = new UnitOfWork("CCATDBEntities");
                Guid _userId = new Guid(userId);
                aspnet_Users user = uo.Repository<aspnet_Users>().GetAll("aspnet_Roles").Where(r => r.UserId == _userId).SingleOrDefault();
                IEnumerable<aspnet_Roles> roles = user.aspnet_Roles;
                return (UserRole) Enum.Parse(typeof(UserRole),uo.Repository<aspnet_Users>().GetAll().Where(r => r.UserId == _userId).SingleOrDefault().aspnet_Roles.SingleOrDefault().RoleName);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
