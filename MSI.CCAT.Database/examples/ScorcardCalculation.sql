select r.*, Case when r.Value = 'N/A' Then 0 ELSE r.Value END from Tbl_QuestionResponse r inner join Tbl_QuestionBank q on q.Id = r.QuestionId 
where r.CreatedBy = '9A0BEE10-1BBD-45AD-81FC-C1E5A70D2115' and q.ModuleId=1 and Value is not null order by r.UpdatedOn desc

Select SUM(Case when r.Value = 'N/A' Then 0 ELSE r.Value END ),r.CreatedBy,q.ModuleId From Tbl_QuestionResponse R INNER JOIN Tbl_QuestionBank Q ON Q.Id = R.QuestionId
Group By r.CreatedBy,q.ModuleId,r.Value
Having r.Value IS Not NULL
