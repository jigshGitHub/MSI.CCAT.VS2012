using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;

namespace MSI.CCAT.Data.Repositories
{
    public class ModuleRepository : RepositoryBase<module>
    {
        public ModuleRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public ModuleRepository()
            : base(new DBFactory("CCATDBEntities"))
        {
        }
    }

    public class PageMenuRepository : RepositoryBase<pageMenu>
    {
        public PageMenuRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public PageMenuRepository()
            : base(new DBFactory("CCATDBEntities"))
        {
        }
    }


    public class PageMenuGroupRepository : RepositoryBase<pageMenuGroup>
    {
        public PageMenuGroupRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public PageMenuGroupRepository()
            : base(new DBFactory("CCATDBEntities"))
        {
        }
    }


}
