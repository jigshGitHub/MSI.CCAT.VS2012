select r.RoleName, u.* from aspnet_Users u inner join aspnet_UsersInRoles ur on ur.UserId = u.UserId inner join aspnet_Roles r on r.RoleId = ur.RoleId order by u.LastActivityDate desc;
select * from Tbl_ModulesForRoles mfr inner join module m on m.moduleId = mfr.ModuleId 
select * from Tbl_Account where AgencyId = 17
select p.*, u.* from aspnet_Users u inner join aspnet_Profile p on p.UserId = u.UserId