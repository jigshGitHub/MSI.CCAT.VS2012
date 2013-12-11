alter table pageMenuGroup add DefaultPage NVARCHAR(1000);
GO;
alter table pageMenuGroup drop column name;
GO
alter table pageMenuGroup add name NVARCHAR(1000);
GO


update pageMenuGroup set DefaultPage='/Dashboard/Home/Overview' where pagemenugroupid=1;
update pageMenuGroup set DefaultPage='/module/DefaultPage?pageMenuGroupId=2' where pagemenugroupid=2;
update pageMenuGroup set DefaultPage='/Audit/Home/Index' where pagemenugroupid=3;
update pageMenuGroup set DefaultPage='/module/DefaultPage?pageMenuGroupId=4' where pagemenugroupid=4;
update pageMenuGroup set DefaultPage='/module/DefaultPage?pageMenuGroupId=5' where pagemenugroupid=5;
update pageMenuGroup set DefaultPage='/Account/ManageUsers' where pagemenugroupid=6;

update pageMenuGroup 
set Name = 'Self-Assessment'
,Caption = 'Self-Assessment'
,[description] = 'We need a field HERE on the page that is populated by the “AssessmentDescription” field that will be in the new “TBL_Descriptions” table.  By having this as a database “field”, the wording can be updated as required with no programming change.  Andy will update the wording in the table once the table has been built.'
,iconpath = 'Images\PC-picture.png'
 where pagemenugroupid=2;

update pageMenuGroup 
set Name = 'Complaint Tracking'
,[description] = 'We need a field HERE on the page that is populated by the “ScorecardDescription” field that will be in the new “TBL_Descriptions” table.  By having this as a database “field”, the wording can be updated as required with no programming change.  Andy will update the wording in the table once the table has been built.'
,iconpath = 'Images\PC-picture.png'
 where pagemenugroupid=4;
 
update pageMenuGroup 
set name = 'Scorecard'
,[description] = 'We need a field HERE on the page that is populated by the “ScorecardDescription” field that will be in the new “TBL_Descriptions” table.  By having this as a database “field”, the wording can be updated as required with no programming change.  Andy will update the wording in the table once the table has been built.'
,iconpath = 'Images\PC-picture.png'
 where pagemenugroupid=5;