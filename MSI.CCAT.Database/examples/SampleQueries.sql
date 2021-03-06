--On Server
-- msi.msiagencycollector (reporting to msi.msiagencymanager)
-- msi.msiagencymanager
-- msi.msiagencycompliance


--DCI Account Numbers for testing 10012096 ,10012134 ,10012141 ,10012149 ,10012152 ,10012170 ,10012176 ,10012184 ,10012198 ,10012208 ,10012248, 10019132, 10045324 ,10045329 ,10045336 ,10045358 ,10045365 ,10047463 ,10078983 ,10118264
-- 10019132, 10012096 ,10012134 ,--john.ac
-- 10012141 ,10012149 --msi.agencymanager
--10012152 ,10012170 ,10012176 --tom.ac
--10012184 ,10012198 --john.dow
--10012208 ,10012248 --john.am
select r.RoleName, u.* from aspnet_Users u inner join aspnet_UsersInRoles ur on ur.UserId = u.UserId inner join aspnet_Roles r on r.RoleId = ur.RoleId order by u.LastActivityDate desc;
select * from Tbl_ModulesForRoles mfr inner join module m on m.moduleId = mfr.ModuleId 

select o.OwnerContact_FirstName + ' ' +  o.OwnerContact_LastName as owner, a.Name,ac.* from Tbl_Account ac 
left join tbl_agency a on a.AgencyId = ac.AgencyId 
left join Tbl_Owner o on o.OwnerId = ac.OwnerId
where 
--ac.accountnumber = '10019132' 
--ac.OwnerId=32 
a.Name = 'DCI'
order by AccountNumber asc
select p.*, u.* from aspnet_Users u inner join aspnet_Profile p on p.UserId = u.UserId order by LastUpdatedDate  desc
select * from Tbl_Agency
select * from tbl_account where accountnumber = '79852631'
--delete from tbl_account where accountnumber = '79852631'
select * from Tbl_Owner 
--delete from Tbl_ComplaintMain where accountnumber = '79852631' order by UpdatedDateTime desc



select * from Tbl_ComplaintMain where AccountNumber = '10458503'
update Tbl_ComplaintMain set ComplaintStatusId = 4 where ComplaintId = 'MSI-555-129'

--delete from Tbl_ComplaintMain where AccountNumber = '10458503' and ComplaintId like 'MSI-132%'

select * from [dbo].[vw_aspnet_membership] where username in('jc.agComp','cheryl.prince','hugh.nichols','john.ac','tom.ac','john.dow','msi.agencymanager','john.am')--'msi.agencyuser','msi.owneruser'
SELECT cm.agencyCollectoruserid,  act.OwnerId,cs.Value,cs.Id,cs.Value,cm.ownerresponsedate, cm.ComplaintStatusId,cm.ComplaintId, u.userName,cm.AccountNumber,  ISNULL (act.LastName,'''') as LastName, ISNULL(act.FirstName,'''') as FirstName, ISNULL(act.LastFourSSN,'''') as LastFourSSN, CONVERT(varchar(20),cm.ComplaintDate,101) as ComplaintDate, CONVERT(varchar(20),cm.MoreInfoRequestedDate,101) as DateRequested, CONVERT(varchar(20),cm.ComplaintSubmittedDate,101) as DateSubmitted, CONVERT(varchar(20),cm.MoreInfoFromAgencyRequestedDate,101) as AgencyRequestDate, CONVERT(varchar(20),cm.AgencyResponseToDebtorDate,101) as ResolvedDate, ci.Name as ComplaintIssue, cm.TotalResponseTimeDays,0 as ResponseTimeDays, ag.Name AS AgencyId
FROM Tbl_ComplaintMain cm
INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId
INNER JOIN aspnet_users u on u.userid = cm.createdby
WHERE cm.accountnumber in (10012096 ,10012134 ,10012141 ,10012149 ,10012152 ,10012170 ,10012176 ,10012184 ,10012198 ,10012208 ,10012248, 10019132, 10045324 ,10045329 ,10045336 ,10045358 ,10045365 ,10047463 ,10078983 ,10118264)

SELECT  
			v.RoleName,
			v.ManagerUsername,
			v.UserName,
			v.FirstName, v.LastName,
			cm.createdby, cm.ComplaintId,
			cm.AccountNumber,  
			ISNULL (act.LastName,'') as LastName, 
			ISNULL(act.FirstName,'') as FirstName,
			ISNULL(act.LastFourSSN,'') as LastFourSSN,
            -- Field no 28
			CONVERT(varchar(20),cm.ComplaintDate,101) as ComplaintDate,
            -- Field no 36
			CONVERT(varchar(20),cm.MoreInfoRequestedDate,101) as DateRequested,
            -- Field no 42
			CONVERT(varchar(20),cm.ComplaintSubmittedDate,101) as DateSubmitted,
			CONVERT(varchar(20),cm.MoreInfoFromAgencyRequestedDate,101) as AgencyRequestDate,
			CONVERT(varchar(20),cm.AgencyResponseToDebtorDate,101) as ResolvedDate,
			ci.Name as ComplaintIssue,
			cm.TotalResponseTimeDays,0 as ResponseTimeDays,
			ag.Name AS AgencyId,            
			cm.OwnerResponseDate
			FROM Tbl_ComplaintMain cm
			LEFT JOIN [dbo].[vw_aspnet_membership] v ON v.UserId = cm.UpdatedBy
			INNER JOIN Tbl_Account act on act.AccountNumber = cm.AccountNumber
			INNER JOIN Tbl_Agency ag on ag.AgencyId = act.AgencyId 
			INNER JOIN Tbl_ComplaintIssues ci on ci.Id = cm.IssuesId
			INNER JOIN Tbl_ComplaintStatus cs on cs.Id = cm.ComplaintStatusId WHERE cs.Value = 'NCIP' AND ag.Name = 'DCI' AND (cm.CreatedBy = '450AFCD9-7A03-495F-A83A-5160950A61EA' OR cm.CreatedBy IN ( SELECT UserId FROM dbo.aspnet_Users WHERE ManagerId = '20D06581-E16C-4229-933E-D60FA514D809'))

select * from aspnet_membership where userid in ('273381B3-5B4F-4BEF-BA38-2C958A429F23','13B9E4F6-E651-424C-9C45-F3EC720C6E40')

--update aspnet_membership set password = 'Y9RdDQZTsjr4H/xWSc8NEPge4Ew=' , passwordsalt = 'QIwACtnWsRwpb0UXpAPtiw==' where userid in ('450AFCD9-7A03-495F-A83A-5160950A61EA','FC44B518-61A1-4A44-8593-124BCFCB0132','20D06581-E16C-4229-933E-D60FA514D809')
--delete from Tbl_ComplaintMain where accountnumber = '10012184'
----update Tbl_ComplaintMain set complaintdate = '12/01/2014' where accountnumber = '10019132'
----update Tbl_ComplaintMain set complaintstatusid = 9 where accountnumber = '10012152'
----update Tbl_ComplaintMain set updatedby = '450AFCD9-7A03-495F-A83A-5160950A61EA' where complaintid = 'DCI-152-501'--'450AFCD9-7A03-495F-A83A-5160950A61EA'
select * from aspnet_Profile where userid='46F37B76-8C34-4E21-B896-413E50933FB6'
--update aspnet_Profile set PropertyValuesString = 'MSImsiagClr' where userid='46F37B76-8C34-4E21-B896-413E50933FB6'

select * from [dbo].[vw_aspnet_membership] where RoleName IN ('AgencyManager','AgencyCollector','AgencyCompliance') and RoleEntityValue = 'DCI'
select * from [dbo].[vw_aspnet_membership] where ManagerId In ('20D06581-E16C-4229-933E-D60FA514D809','6E3419BE-69C6-4114-B237-803AF84AA73E')

--EXEC [sp_FilteredReportSearch] 'ComplaintID ASC',10,1,'','FC44B518-61A1-4A44-8593-124BCFCB0132,450AFCD9-7A03-495F-A83A-5160950A61EA','5B0036B0-245B-4C55-90E4-37EB123771F3'


--delete from aspnet_profile where userId in ('46F37B76-8C34-4E21-B896-413E50933FB6','26334469-2BFC-4124-9D02-86B86CC1FAA2','3DD66290-6835-4FDA-A6D3-DBC3D8B1E95F');
--delete from aspnet_UsersInRoles where userId in ('46F37B76-8C34-4E21-B896-413E50933FB6','26334469-2BFC-4124-9D02-86B86CC1FAA2','3DD66290-6835-4FDA-A6D3-DBC3D8B1E95F');
--delete from aspnet_users where userId in ('46F37B76-8C34-4E21-B896-413E50933FB6','26334469-2BFC-4124-9D02-86B86CC1FAA2','3DD66290-6835-4FDA-A6D3-DBC3D8B1E95F');
--delete from aspnet_Membership where userId in ('46F37B76-8C34-4E21-B896-413E50933FB6','26334469-2BFC-4124-9D02-86B86CC1FAA2','3DD66290-6835-4FDA-A6D3-DBC3D8B1E95F');