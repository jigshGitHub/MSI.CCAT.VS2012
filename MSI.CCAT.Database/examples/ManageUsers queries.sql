
select u.UserName, u.ManagerId,m.UserId,m.Email,m.IsLockedOut from aspnet_Membership m 
inner join aspnet_Users u on m.UserId = u.UserId;

select * from vw_aspnet_Membership;

--delete from aspnet_UsersInRoles where UserId In ('0F573A4A-A283-413A-8E1E-413E76D885DC','10AE081F-0246-4303-8D44-677F950DDA33','A7CCEA5A-460F-4954-A339-0020975978C2');
--delete from aspnet_Profile where UserId In ('0F573A4A-A283-413A-8E1E-413E76D885DC','10AE081F-0246-4303-8D44-677F950DDA33','A7CCEA5A-460F-4954-A339-0020975978C2');
--delete from aspnet_Membership where UserId In ('0F573A4A-A283-413A-8E1E-413E76D885DC','10AE081F-0246-4303-8D44-677F950DDA33','A7CCEA5A-460F-4954-A339-0020975978C2');
--delete from aspnet_users where UserId In ('0F573A4A-A283-413A-8E1E-413E76D885DC','10AE081F-0246-4303-8D44-677F950DDA33','A7CCEA5A-460F-4954-A339-0020975978C2');
