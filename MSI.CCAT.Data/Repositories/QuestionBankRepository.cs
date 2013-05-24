using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MSI.CCAT.Data.Models;
namespace MSI.CCAT.Data.Repositories
{
    public class QuestionBankRepository :  RepositoryBase<Tbl_QuestionBank>
    {
        public QuestionBankRepository(IDatabaseFactory dbFactory)
            : base(dbFactory)
        {
        }
        public QuestionBankRepository()
            : base(new DBFactory())
        {
        }
    }
}
