use CCATDB
select  m.Name,m.[IndustryAverage], r.*, Case when r.Value = 'N/A' Then 0 ELSE r.Value END 
from Tbl_QuestionResponse r inner join Tbl_QuestionBank q on q.Id = r.QuestionId 
inner join Tbl_QuestionModule m on m.Id = q.ModuleId
where r.CreatedBy = '9A0BEE10-1BBD-45AD-81FC-C1E5A70D2115' 
and Value is not null and q.ModuleId=7  order by r.UpdatedOn desc


select ((SUM(case when r.value = 'N/A' then 0 else r.value end)*20)/m.QuetionQuantity) as totalvalue,q.ModuleId,r.CreatedBy,m.Name,m.industryaverage,m.QuetionQuantity
from Tbl_QuestionResponse r left join Tbl_QuestionBank q on q.Id = r.QuestionId 
left join Tbl_QuestionModule m on m.Id = q.ModuleId
where 
r.CreatedBy='9A0BEE10-1BBD-45AD-81FC-C1E5A70D2115'
-- and r.Value is not  null
group by q.ModuleId,r.CreatedBy,m.Name,m.industryaverage,m.QuetionQuantity
