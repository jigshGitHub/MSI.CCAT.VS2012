update [pageMenuGroup] set caption='Assessment' where pageMenuGroupId=2;
update [pageMenuGroup] set caption='Ongoing Tracking' where pageMenuGroupId=4;
update [pageMenuGroup] set caption='Recommendations' where pageMenuGroupId=3;

SET IDENTITY_INSERT [dbo].[pageMenu] ON
INSERT [dbo].[pageMenu] ([pageMenuId], [appId], [name], [shortCaption], [longCaption], [description], [iconPath], [pagePath], [pageParams], [isNewWindow], [isModal], [inIFRAME], [aElementIdentifier]) VALUES 
(32, 1, N'Scorcard', N'Scorecard', N'Scorecard', NULL, NULL, N'/CCATDev/Scorecard/Home/Index', NULL, 0, 0, 0, N'')
SET IDENTITY_INSERT [dbo].[pageMenu] OFF

SET IDENTITY_INSERT [dbo].[pageMenuGroup] ON
INSERT [dbo].[pageMenuGroup] ([pageMenuGroupId], [appId], [name], [caption], [description], [iconPath], [iconClass], [pageMenuIds]) VALUES 
(5, 1, N'Scorecard', N'Scorecard', NULL, NULL, NULL, N'32')
SET IDENTITY_INSERT [dbo].[pageMenu] OFF

Update [module] Set pageMenuGroups = '1,2,5,3' Where moduleId=1;
Update [module] Set pageMenuGroups = '4' Where moduleId=2;

