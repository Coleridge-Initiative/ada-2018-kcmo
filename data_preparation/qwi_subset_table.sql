DROP TABLE IF EXISTS ada_kcmo.qwi_sample_table;
create table ada_kcmo.qwi_sample_table as
select *
from (
	select x.*, y.count
	from kcmo_lehd.mo_wage as x
	left join (
		select *
		from(
			select * 
			from(
				select ein, count(distinct run ) as count
				from kcmo_lehd.mo_qcew_employers 
				where year = 2010 and qtr = 1  
				group by ein
			) as a
			where count > 1
			LIMIT 5
		) as b
		UNION
		select *
		from(
			select * 
			from(
				select ein, count(distinct run ) as count
				from kcmo_lehd.mo_qcew_employers 
				where year = 2010 and qtr = 1  
				group by ein
			) as c
			where count = 1
			LIMIT 5
		) as d
	) as y
	on x.ein = y.ein
) as z
where count is not null;

alter table ada_kcmo.qwi_sample_table owner to ada_kcmo_admin;

commit;
