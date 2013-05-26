using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.Data.Repositories
{
    public class QuestionResponseRepository : RepositoryBase<Tbl_QuestionResponse>
    {
        public QuestionResponseRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public QuestionResponseRepository()
            : base(new DBFactory())
        {
        }
    }
}
