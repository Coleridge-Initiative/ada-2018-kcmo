-- make a new table where the dates are date type rather 
-- than text to do date manipulation
\echo "Munging The Data"
CREATE TABLE if NOT EXISTS ada_class3.ind_spells_dates AS 
SELECT 	recptno, 
	benefit_type,
	to_date(start_date::text,'YYYY-MM-DD') start_date,
	to_date(end_date::text, 'YYYY-MM-DD') end_date
FROM idhs.ind_spells;

-- subset for 2014 of everyone on tanf46
CREATE TABLE if NOT EXISTS ada_class3.individual_spells_2014 AS
SELECT *
FROM ada_class3.ind_spells_dates
WHERE 	start_date > '2014-06-01' and
      	end_date > '2014-12-31' and
	benefit_type = 'tanf46';
-- make an index for faster queries 
CREATE INDEX if NOT EXISTS recptno_ind 
ON ada_class3.individual_spells_2014 (recptno); 

-- subset for 2015 of everone on tanf46
CREATE TABLE if NOT EXISTS ada_class3.individual_spells_2015 AS
SELECT 	*
FROM 	ada_class3.ind_spells_dates
WHERE 	start_date > '2015-01-01' AND
      	end_date > '2015-12-31' and
	benefit_type = 'tan46';
-- make an index for faster queries
CREATE INDEX if NOT EXISTS receptno_ind 
ON ada_class3.individual_spells_2015 (recptno); 

--grab the records of everyone in 2014 that did not have
--benefits in 2015
CREATE TABLE if NOT EXISTS ada_class3.benefits_2014_not2015 as 
SELECT 	a.recptno recptno_2014,
	a.benefit_type benefit_type_2014,
	a.start_date start_date_2014,
	a.end_date end_date_2014,
	b.recptno recptno_2015,
	b.benefit_type benefit_type_2015,
	b.start_date start_date_2015,
	b.end_date end_date_2015,
	c.ssn_hash ssn_hash	
FROM ada_class3.individual_spells_2014 a
LEFT JOIN ada_class3.individual_spells_2015 b ON a.recptno = b.recptno
LEFT JOIN idhs.member c ON a.recptno = c.recptno
WHERE b.recptno IS NULL;

--grab the first quarter date from the ides data
CREATE TABLE IF NOT EXISTS ada_class3.ssn_ein_2015_1 as
SELECT ssn, ein
FROM ides.il_wage
where ssn in (select distinct(ssn_hash) from ada_class3.benefits_2014_not2015)
and year = 2015
and quarter = 1; 

CREATE TABLE IF NOT EXISTS ada_class3.ssn_ein AS                       
SELECT ssn,ein, count(*)
FROM ada_class3.ssn_ein_2015_1
GROUP BY ssn, ein
ORDER BY 3 desc;

\echo "making the network"
DROP TABLE IF EXISTS ada_class3.ein_network; 
CREATE TABLE IF NOT EXISTS ada_class3.ein_network AS
SELECT 	a.ssn ssn_l, 
	a.ein,
	b.ssn ssn_r
FROM ada_class3.ssn_ein a
JOIN ada_class3.ssn_ein b on a.ein = b.ein; 

DELETE FROM ada_class3.ein_network 
WHERE ssn_l = ssn_r
OR ein = '000000000'
OR ein='0';

--map the ein number to legal name 
-- of the entity. 

DROP TABLE IF EXISTS ada_class3.ein_name;
CREATE TABLE ada_class3.ein_name AS
SELECT ein, name_legal, count(*)
from ides.il_qcew_employers
group by ein, name_legal
order by 3 desc;

DROP TABLE IF EXISTS ada_class3.ein_network_2015;
CREATE TABLE ada_class3.ein_network_2015 AS
SELECT n.ssn_l, n.ein, e.name_legal, n.ssn_r
FROM ada_class3.ein_network n
JOIN ada_class3.ein_name e ON n.ein = e.ein;

DELETE FROM ada_class3.ein_network_2015
WHERE name_legal = 'nan';




