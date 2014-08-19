using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;

namespace MSI.CCAT.Data.Repositories
{
    public class AccountsRepository : RepositoryBase<Tbl_Account>
    {
        public AccountsRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public AccountsRepository()
            : base(new DBFactory("CCATDBEntities"))
        {
        }

        public IEnumerable<Tbl_Account> GetAccounts()
        {
            return (this.DatabaseFactory.Get() as CCATDBEntities).GetAccounts();
        }
        public IEnumerable<Tbl_Account> GetAccounts(string accountNumber)
        {
            return (this.DatabaseFactory.Get() as CCATDBEntities).GetAccountsByNumber(accountNumber);
        }
    }
}
