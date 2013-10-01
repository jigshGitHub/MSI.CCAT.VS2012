alter table Tbl_QuestionModule add ScoringLegend nvarchar(1000);
go

update Tbl_QuestionModule set name = 'Entity Business Model', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =1;
update Tbl_QuestionModule set name = 'Communications in Connection with Debt Collection', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =2;
update Tbl_QuestionModule set name = 'Information Sharing & Privacy', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =3;
update Tbl_QuestionModule set name = 'Consumer Companies & Resolutions', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =4;
update Tbl_QuestionModule set name = 'Equal Credit Opportunity Act', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =5;
update Tbl_QuestionModule set name = 'Litigation Practices & Repossession', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =6;
update Tbl_QuestionModule set name = 'Payment Processing and Account Maintenance', ScoringLegend = '1 = Need Help, 2 = Barely Compliant, 3 = Somewhat Compliant, 4 = Mostly Compliant, 5 = Compliant' where ID =7;

update [pageMenuGroup] set [description] = null, iconPath = null, defaultpage=null;
update [pageMenuGroup] set pagemenuids = '34,2,3,4,6,7,8,9' where [pageMenuGroupId] = 2;
update [pageMenuGroup] set pagemenuids = '35,23,24,25,26,27,28,29,31' where [pageMenuGroupId] = 4;
update [pageMenuGroup] set pagemenuids = '32' where [pageMenuGroupId] = 5;

INSERT INTO [dbo].[pageMenu] ([appId] ,[name] ,[shortCaption] ,[longCaption] ,[description] ,[iconPath] ,[pagePath])
     VALUES (1 ,'Self-Assessment' ,'General information' ,'General information' ,'This Self-Assessment is provided to allow you to conduct an honest assessment of your compliance.' ,'Images\PC-picture.png' ,'/CCATDev/module/DefaultPage?pageMenuId=34&pageMenuGroupId=2')

INSERT INTO [dbo].[pageMenu] ([appId] ,[name] ,[shortCaption] ,[longCaption] ,[description] ,[iconPath] ,[pagePath])
     VALUES (1 ,'Complaint Tracking' ,'General information' ,'General information' ,'We need a field HERE on the page that is populated by the “ScorecardDescription” field that will be in the new “TBL_Descriptions” table.  By having this as a database “field”, the wording can be updated as required with no programming change.  Andy will update the wording in the table once the table has been built.' ,'Images\PC-picture.png' ,'/CCATDev/module/DefaultPage?pageMenuId=35&pageMenuGroupId=4')

Update pageMenu Set [description] = 'We need a field HERE on the page that is populated by the “ScorecardDescription” field that will be in the new “TBL_Descriptions” table.  By having this as a database “field”, the wording can be updated as required with no programming change.  Andy will update the wording in the table once the table has been built.' 
,iconPath = 'Images\PC-picture.png' 
,pagePath = '/CCATDev/module/DefaultPage?pageMenuId=32&pageMenuGroupId=5'
where pagemenuid=32;