Update CCATDB.dbo.pageMenu Set pagePath =  REPLACE(pagepath,'/CCATDev','') ;

Select *, REPLACE(pagepath,'/CCATDev','') from CCATDB.dbo.pageMenu