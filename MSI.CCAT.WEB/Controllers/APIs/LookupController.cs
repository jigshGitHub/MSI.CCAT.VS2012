using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Cascade.Data.Models;
using Cascade.Data.Repositories;
using MSI.CCAT.Data.Models;
using MSI.CCAT.Data.Repositories;
namespace MSI.CCAT.WEB.Controllers.APIs
{
    public class LookupController : ApiController
    {
        public IEnumerable<LookUp> Get(string id)
        {
            IEnumerable<LookUp> lookupData = null;
            List<LookUp> data = new List<LookUp>();
            UnitOfWork uo;
            switch (id)
            {
                case "Agencies":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from agency in uo.Repository<Tbl_Agency>().GetAll()
                                 select new LookUp(agency.Name, agency.Name );
                    break;
                case "ComplaintIssues":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from issue in uo.Repository<Tbl_ComplaintIssues>().GetAll()
                                 select new LookUp(issue.Name, issue.Id.ToString());
                    break;
                case "ComplaintReceivedBy":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from receiver in uo.Repository<Tbl_ComplaintReceivedBy>().GetAll()
                                 select new LookUp(receiver.Media, receiver.Id.ToString());
                    break;
                case "DebtorContactMethods":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from method in uo.Repository<Tbl_DebtorContactMethods>().GetAll()
                                 select new LookUp(method.Method, method.Id.ToString());
                    break;
                case "DebtorContactTime":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from time in uo.Repository<Tbl_DebtorContactTime>().GetAll()
                                 select new LookUp(time.Time, time.Id.ToString());
                    break;
                case "DetorProducts":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from product in uo.Repository<Tbl_DebtorProducts>().GetAll()
                                 select new LookUp(product.Product, product.Id.ToString());
                    break;
                case "OwnerResponse":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from response in uo.Repository<Tbl_OwnerResponses>().GetAll()
                                 select new LookUp(response.Response, response.OwnerResponseId.ToString());
                    break;
                case "FinalActionSteps":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from step in uo.Repository<Tbl_FinalActionSteps>().GetAll()
                                 select new LookUp(step.Step, step.Id.ToString());
                    break;
                case "USStates":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from state in uo.Repository<Tbl_States>().GetAll()
                                 select new LookUp(state.Name, state.Id.ToString());
                    break;
                case "CreditIssuers":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from issue in uo.Repository<Tbl_CreditIssuer>().GetAll()
                                 select new LookUp(issue.CreditorName, issue.CreditIssuerId.ToString());
                    break;
                case "LawFirm":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from firm in uo.Repository<Tbl_LawFirm>().GetAll()
                                 select new LookUp(firm.Name, firm.LawFirmId.ToString());
                    break;

                case "DebtOwner":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from owner in uo.Repository<Tbl_Owner>().GetAll()
                                 select new LookUp(owner.Name, owner.OwnerId.ToString());
                    break;
                case "ComplaintTypes":
                    uo = new UnitOfWork("CCATDBEntities");
                    lookupData = from cType in uo.Repository<Tbl_ComplaintType>().GetAll()
                                 select new LookUp(cType.Name, cType.Id.ToString());
                    break; 
                default:
                    break;
            }
            return lookupData;
        }
        /// <summary>
        /// This is used to Add Decscription with the Text Property in DDL
        /// </summary>
        /// <param name="_descriptionText"></param>
        /// <returns></returns>
        public string GetDescriptionDetails(string _descriptionText)
        {
            if (!string.IsNullOrEmpty(_descriptionText))
            {
                //We have value
                return " | " + _descriptionText;
            }
            else
            {
                return "";
            }
        }
        public class Product_CodeDistinct : IEqualityComparer<RACCOUNT>
        {

            #region IEqualityComparer<Task> Members

            public bool Equals(RACCOUNT x, RACCOUNT y)
            {
                return x.PRODUCT_CODE == y.PRODUCT_CODE;
            }

            public int GetHashCode(RACCOUNT obj)
            {
                return obj.PRODUCT_CODE.GetHashCode();
            }

            #endregion
        }
    }
}