create table if NOT EXISTS ada_kcmo.mo_ssn_total_wages as
select ssn, year, quarter, count(*) as total_jobs, sum(wage) as total_wages
from kcmo_lehd.mo_wage
group by ssn, year, quarter
order by ssn, year, quarter
;

alter table ada_kcmo.mo_ssn_total_wages owner to ada_kcmo_admin;
commit;
