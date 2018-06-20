select 
	{geography}
	, sum(nb_jobs) as jobs
	, sum(nb_jobs * avg_wage)/sum(nb_jobs) as avg_wage
from ada_kcmo.{data_table}
where year = {year} and qtr = {qtr} 
	and wage_bucket >= {min_wage} and wage_bucket < {max_wage}
	and naics in {industries}
group by {geography}
having sum(nb_jobs) >= 10
