select 
	a.{geography}
	, b.jobs - a.jobs as change_in_jobs
	, (b.jobs - a.jobs)/(a.jobs + 1) as change_in_jobs_pct
	, b.avg_wage - a.avg_wage as change_in_avg_wage
	, (b.avg_wage - a.avg_wage)/(a.avg_wage + 1) as change_in_avg_wage_pct
from(
	select {geography}, sum(nb_jobs) as jobs, sum(nb_jobs*avg_wage)/sum(nb_jobs) as avg_wage
	from ada_kcmo.{data_table}
	where year = {start_year} and qtr = {start_qtr} 
		and wage_bucket >= {min_wage} and wage_bucket < {max_wage} 
		and naics in {industries}
	group by {geography}
) as a
full join (
	select {geography}, sum(nb_jobs) as jobs, sum(nb_jobs*avg_wage)/sum(nb_jobs) as avg_wage
	from ada_kcmo.{data_table}
	where year = {end_year} and qtr = {end_qtr} 
		and wage_bucket >= {min_wage} and wage_bucket < {max_wage} 
		and naics in {industries}
	group by {geography}
) as b
on a.{geography} = b.{geography}
where a.jobs >= 10 and b.jobs >= 10 and abs(b.jobs - a.jobs) >= 10

