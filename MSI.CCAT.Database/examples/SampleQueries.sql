select r.RoleName, u.* from aspnet_Users u inner join aspnet_UsersInRoles ur on ur.UserId = u.UserId inner join aspnet_Roles r on r.RoleId = ur.RoleId order by u.LastActivityDate desc;
select * from Tbl_ModulesForRoles mfr inner join module m on m.moduleId = mfr.ModuleId 
select u.UserName,dbo.fn_GetProfileElement(,p.* from aspnet_profile p inner join aspnet_Users u on u.UserId = p.UserId;

select o.OwnerContact_FirstName + ' ' +  o.OwnerContact_LastName as owner, a.Name,ac.* from Tbl_Account ac 
left join tbl_agency a on a.AgencyId = ac.AgencyId 
left join Tbl_Owner o on o.OwnerId = ac.OwnerId
where ac.accountnumber = '11114444' ac.OwnerId=32 order by AccountNumber asc
select p.*, u.* from aspnet_Users u inner join aspnet_Profile p on p.UserId = u.UserId order by LastUpdatedDate  desc
select * from Tbl_Agency

select * from Tbl_Owner 
select * from Tbl_ComplaintMain order by UpdatedDateTime desc

SELECT cm.agencyCollectoruserid,  act.OwnerId,cs.Value,cs.Id,cm.ComplaintId, cm.AccountNumber,  ISNULL (act.LastName,'''') as LastName, ISNULL(act.FirstName,'''') as FirstName, ISNULL(act.LastFourSSN,'''') as LastFourSSN, CONVERT(varchar(20),cm.ComplaintDate,101) as ComplaintDate, CONVERT(varchar(20),cm.MoreInfoRequestedDate,101) as DateRequested, CONVERT(varchar(20),cm.ComplaintSubmittedDate,101) as DateSubmitted, CONVERT(varchar(20),cm.MoreInfoFromAgencyRequestedDate,101) as AgencyRequestDate, CONVERT(varchar(20),cm.AgencyResponseToDebtorDate,101) as ResolvedDate, ci.Name as ComplaintIssue, cm.TotalResponseTimeDays,0 as ResponseTimeDays, ag.Name AS AgencyId
FROM Tbl_ComplaintMain cm
INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId
WHERE cm.accountnumber = '10458503'-- cs.Value = 'NCRA' and act.OwnerId = 32

select * from Tbl_ComplaintMain where AccountNumber = '10458503'
update Tbl_ComplaintMain set ComplaintStatusId = 4 where ComplaintId = 'MSI-555-129'

--delete from Tbl_ComplaintMain where AccountNumber = '10458503' and ComplaintId like 'MSI-132%'

select * from [dbo].[vw_aspnet_membership] where username = 'msi.demoagency'


