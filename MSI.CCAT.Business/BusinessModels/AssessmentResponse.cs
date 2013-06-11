using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MSI.CCAT.Business.BusinessModels
{
    public class AssessmentResponse
    {
        public string Question { get; set; }
        public string QuestionTooltip { get; set; }
        public int QuestionId { get; set; }
        public int ModuleId { get; set; }
        public string SerialNumber { get; set; }
        public int ResponseId { get; set; }
        public string Response { get; set; }
        public Guid UserId { get; set; }
    }
}
