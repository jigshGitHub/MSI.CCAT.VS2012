IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetElement]') AND type in (N'FN'))
	DROP FUNCTION [dbo].[fn_GetElement]
GO


CREATE FUNCTION dbo.fn_GetElement
(
@ord AS INT,
@str AS VARCHAR(8000),
@delim AS VARCHAR(1) )
 
RETURNS INT
AS
BEGIN
  -- If input is invalid, return null.
  IF @str IS NULL
      OR LEN(@str) = 0
      OR @ord IS NULL
      OR @ord < 1
      -- @ord > [is the] expression that calculates the number of elements.
      OR @ord > LEN(@str) - LEN(REPLACE(@str, @delim, '')) + 1
    RETURN NULL
  DECLARE @pos AS INT, @curord AS INT
  SELECT @pos = 1, @curord = 1
  -- Find next element's start position and increment index.
  WHILE @curord < @ord
    SELECT
      @pos    = CHARINDEX(@delim, @str, @pos) + 1,
      @curord = @curord + 1
  RETURN
  CAST(SUBSTRING(@str, @pos, CHARINDEX(@delim, @str + @delim, @pos) - @pos) AS INT)
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_GetProfileElement]') AND type in (N'FN'))
	DROP FUNCTION [dbo].[fn_GetProfileElement]
GO

CREATE FUNCTION dbo.fn_GetProfileElement
(
@fieldName AS NVARCHAR(100),
@fields AS NVARCHAR(4000),
@values AS NVARCHAR(4000))
 
RETURNS NVARCHAR(4000)
AS
BEGIN
  -- If input is invalid, return null.
  IF @fieldName IS NULL
      OR LEN(@fieldName) = 0
      OR @fields IS NULL
      OR LEN(@fields) = 0
      OR @values IS NULL
      OR LEN(@values) = 0
 
    RETURN NULL
 
-- locate FieldName in Fields
DECLARE @fieldNameToken AS NVARCHAR(20)
DECLARE @fieldNameStart AS INTEGER,
@valueStart AS INTEGER,
@valueLength AS INTEGER
 
-- Only handle string type fields (:S:)
SET @fieldNameStart = CHARINDEX(@fieldName + ':S',@Fields,0)
 
-- If field is not found, return null
IF @fieldNameStart = 0 RETURN NULL
SET @fieldNameStart = @fieldNameStart + LEN(@fieldName) + 3
 
-- Get the field token which I've defined as the start of the
-- field offset to the end of the length
SET @fieldNameToken = SUBSTRING(@Fields,@fieldNameStart,LEN(@Fields)-@fieldNameStart)
 
-- Get the values for the offset and length
SET @valueStart = dbo.fn_getelement(1,@fieldNameToken,':')
SET @valueLength = dbo.fn_getelement(2,@fieldNameToken,':')
 
-- Check for sane values, 0 length means the profile item was
-- stored, just no data
IF @valueLength = 0 RETURN ''
 
-- Return the string
RETURN SUBSTRING(@values, @valueStart+1, @valueLength)
 
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_membership]') AND type in (N'V'))
	DROP VIEW [dbo].[vw_aspnet_membership]

GO

Create View [dbo].[vw_aspnet_membership]
AS
select u.UserName,u.LastActivityDate,u.AgencyId,a.Name as AgencyName,u.OwnerId,o.Name as OwnerName,u.LawFirmId,l.Name as LawFirmName,u.ManagerId, mg.UserName as ManagerUsername
,r.RoleName
,dbo.fn_GetProfileElement('FirstName',PropertyNames,PropertyValuesString) as FirstName
,dbo.fn_GetProfileElement('LastName',PropertyNames,PropertyValuesString) as LastName
,dbo.fn_GetProfileElement('RoleEntityValue',PropertyNames,PropertyValuesString) as RoleEntityValue
,m.UserId,m.Email,m.IsLockedOut,m.IsApproved, m.LastLoginDate, m.LastPasswordChangedDate, m.LastLockoutDate,m.Comment 
from aspnet_Membership m 
inner join aspnet_Users u on m.UserId = u.UserId
left join aspnet_UsersInRoles ur on ur.UserId = m.UserId
left join aspnet_Roles r on ur.RoleId = r.RoleId
left join aspnet_Profile p on p.UserId = m.UserId
left join tbl_agency a on a.AgencyId = u.AgencyId
left join tbl_owner o on o.OwnerId = u.OwnerId
left join Tbl_LawFirm l on l.LawFirmId = u.LawFirmId
left join aspnet_users mg on mg.UserId = u.ManagerId;
GO
