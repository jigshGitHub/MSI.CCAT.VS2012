
select u.UserName, u.ManagerId,m.UserId,m.Email,m.IsLockedOut from aspnet_Membership m 
inner join aspnet_Users u on m.UserId = u.UserId;

select * from vw_aspnet_Membership;
