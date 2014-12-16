using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MSI.Data.Models
{
    public class SearchResult
    {
        public string Name { get; set; }
        public string ProductDescription { get; set; }
        public string WorkStatusDescription { get; set; }
        public string Seller { get; set; }
        public string Originator { get; set; }
        public string ACCOUNT { get; set; }
        public string StatusDescription { get; set; }
        public string RespAgency { get; set; }
                
        public SearchResult()
        {
        }
    }

    public class Purchases
    {
        public string ACCOUNT;
        public string PRODUCT_CODE;
        public DateTime? PurchaseDate;
        public Decimal? OriginalBalance;
        public Decimal? purchaseprice;
        public string Seller;
        public Purchases()
        {
        }
    }

    public class Sales
    {
        public string ACCOUNT;
        public string PRODUCT_CODE;
        public string Responsibility;
        public DateTime? SoldDate;
        public Decimal? SalesPrice;
        public Decimal? FaceValue;
        public Sales()
        {
        }
    }

    public class PortfolioTransactions
    {
        public string ACCOUNT;
        public string PRODUCT_CODE;
        public string Responsibility;
        public DateTime? Tran_Date;
        public Decimal? Amount;
        public string TRAN_CODE;
        public string TRAN_SOURCE;
        public PortfolioTransactions()
        {
        }
    }

    public class PortfolioSummary
    {
        public string Description;
        public string Type;
        public int Accounts;
        public Decimal? Balance;
        public string ShortDescription;
        public string Seller;
        public string Status;
        public PortfolioSummary()
        {
        }
    }

    public class DPSViewEditResult
    {
        public string Portfolio;
        public string AcctName;
        public Decimal? Amount;
        public Decimal? NetPayment;
        public string CheckNumber;
        public string PmtType;
        public string TransSource;
        public string TransCode;
        public string CurrentResp;
        public string OurCheckNumber;
        public string Uploaded;
        public DateTime? TransDate;
        public DateTime? DateRec;
        public string PIMSAcct;
        public string OriginalAcct;
        public string GUID;
        public int ID;
        public Decimal? TotalAmount;
        public DPSViewEditResult()
        {
        }

    }
    
    public class MediaViewEditResult
    {
        public string Portfolio;
        public string AcctName;
        public Decimal? SellerFee;
        public Decimal? OurFee;
        public DateTime? OrderDate;
        public DateTime? OpenDate;
        public DateTime? CODate;
        public string PIMSAcct;
        public string OrigAcct;
        public string GUID;
        public int ID;
        public string CompanyRequesting;
        public string OriginalLender;
        public string SSN;
        public string IsApplication;
        public string IsAffidavitIssuer;
        public string IsAffidavitSeller;
        public string IsUnavailable;
        public string IsClosed;
        public string Explanation;
        public string MediaTypeReceived;
        public string Notes;
        public string SellerInvoice;
        public string BuyerCheck;
        public string OurCheck;
        public string Seller;
        public string OrderNumber;
        public string OurInvoice;
        public DateTime? StmtsFrom;
        public DateTime? StmtsTo;
        public DateTime? DateSubmitted;
        public DateTime? DateConfirmed;
        public DateTime? DateSellerPaid;
        public DateTime? DateReceived;
        public DateTime? DateForwarded;
        public DateTime? UnavailableDate;
        public DateTime? DatePayRec;
        public string FileName;
        public MediaViewEditResult()
        {
        }

    }

    public partial class vwAccount
    {
        public string GUID;
    }

    #region Recalls

    public class RecallViewEditResult
    {
        public string Portfolio;
        public string AcctName;
        public Decimal? FaceValueofAcct;
        public DateTime? DateNoteSent;
        public DateTime? DateAcctClosed;
        public DateTime? Date;
        public DateTime? UploadedDate;
        public string CurrentResp;
        public string RecallReason;
        public string NewStatus;
        public string NewResp;
        public string CheckNumber;
        public string Invoice;
        public string Explanation;
        public Decimal? CostBasis;
        public Decimal? SalesBasis;
        public string SellerCheck;
        public string Putback;
        public Decimal? AmtReceivable;
        public Decimal? AmtPayable;
        public string Seller;
        public string PIMSAcct;
        public string OrigAcct;
        public string GUID;
        public int ID;
        public Decimal? TotalAmount;
        public string InitiatedBy;
        public string CheckDocuments;
        public RecallViewEditResult()
        {
        }
    }

    public class PutBackViewEditResult
    {
        public string Portfolio;
        public string AcctName;
        public Decimal? FaceValueofAcct;
        public DateTime? DateNoteSent;
        public DateTime? DateAcctClosed;
        public DateTime? Date;
        public DateTime? UploadedDate;
        public string CurrentResp;
        public string PutBackReason;
        public string NewStatus;
        public string NewResp;
        public string CheckNumber;
        public string Invoice;
        public string Explanation;
        public Decimal? CostBasis;
        public Decimal? SalesBasis;
        public string SellerCheck;
        public Decimal? AmtReceivable;
        public Decimal? AmtPayable;
        public string Seller;
        public string PIMSAcct;
        public string OrigAcct;
        public string GUID;
        public int ID;
        public Decimal? TotalAmount;
        public string InitiatedBy;
        public string CheckDocuments;
        public PutBackViewEditResult()
        {
        }
    }

    #endregion
    
    public class ComplianceReportResult_Ext
    {
        public string LastName;
        public string FirstName;
        public string FullName;
        public string UpdatedByLastName;
        public string UpdatedByFirstName;
        public string UpdatedByFullName;
        public string AgentLastName;
        public string AgentFirstName;
        public string AgentFullName;
        public string AccountNumber;
        public string ComPlaintId;
        public string LastFourSSN;
        public string AgencyId;
        public string ComplaintIssue;
        public DateTime? ComplaintDate;
        public DateTime? ResolvedDate;
        public DateTime? DateRequested;
        public DateTime? DateSubmitted;
        public DateTime? AgencyRequestDate;
        public DateTime? OwnerResponseDate;
        public DateTime? UpdatedDateTime;
        public int? ResponseTimeDays;
        public int? TotalResponseTimeDays;
        public int count_ { get; set; }
        public Int64 rowNo { get; set; }
        public ComplianceReportResult_Ext()
        {
        }

    }


    #region Testing
    public class PeopleViewEditResult
    {
        public string FName;
        public string LName;
        public string Address;
        public DateTime? CreatedAt;
        public int PID;
        public PeopleViewEditResult()
        {
        }
    }

    public class MoneyViewEditResult
    {
        public DateTime? CreatedAt;
        public int MID;
        public Decimal? Amount;
        public string SText;
        public string FName;
        public string LName;
        public MoneyViewEditResult()
        {
        }
    }

    public class SourceViewEditResult
    {
        public DateTime? CreatedAt;
        public int SID;
        public string  SText;
        public SourceViewEditResult()
        {
        }
    }
    #endregion
    

}
