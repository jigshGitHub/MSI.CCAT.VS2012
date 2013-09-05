select ag.Name as agency, ci.CreditorName,lf.Name, o.Name as ownerame, a.* from Tbl_Account a
left join Tbl_Agency ag on ag.AgencyId = a.AgencyId
left join Tbl_CreditIssuer ci on ci.CreditIssuerId = a.CreatedOn
left join Tbl_LawFirm lf on lf.LawFirmId = a.LawFirmId
left join Tbl_Owner o on o.OwnerId = a.OwnerId;
