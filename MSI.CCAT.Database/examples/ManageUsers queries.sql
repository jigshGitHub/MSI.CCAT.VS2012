/****** Script for SelectTopNRows command from SSMS  ******/
use [CCATDB];
select u.UserName,r.RoleName, p.PropertyValuesString,m.* from aspnet_Membership m 
inner join aspnet_Users u on m.UserId = u.UserId
left join aspnet_UsersInRoles ur on ur.UserId = m.UserId
left join aspnet_Roles r on ur.RoleId = r.RoleId
left join aspnet_Profile p on p.UserId = m.UserId;
select * from aspnet_Profile;
SELECT TOP 1000 [UserId]
      ,[RoleId]
  FROM [CCATDB].[dbo].[aspnet_UsersInRoles]