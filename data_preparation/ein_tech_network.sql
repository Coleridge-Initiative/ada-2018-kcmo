-- NETWORK STUFF

/*
First, let's subset the wage record data to High Tech industries.
Using the list of High Tech Industry NAICS codes developed by Hecker (2005), we restrict the employer data to those in Technology Industries. We then merge the wage data onto this subset in order to keep only EINs associated with High Tech NAICS codes.
The resulting table is saved in the KCMO_ada schema.
*/

DROP TABLE IF EXISTS ada_kcmo.mo_tech_jobs_2016;
CREATE TABLE ada_kcmo.mo_tech_jobs_2016 AS
SELECT *
FROM (
	-- Left Join the 2016 mo_wage table on the list of unique EINs for a list of tech jobs.
	SELECT a.ein, b.ssn, b.quarter
	FROM (
		-- Group by EIN to generate a list of unique EINs in the tech industry.
		SELECT *
		FROM (
			-- Subset the employers data to tech industries. 
			SELECT ein
			FROM kcmo_lehd.mo_qcew_employers
			WHERE year = 2016
				AND left(naics, 4) in (
					-- Hecker (2005) LEVEL I TECH INDUSTRIES 
					'3254', '3341', '3342', '3344', '3345', '3364', '5112'
					, '5161', '5179', '5181', '5182', '5413', '5415', '5417'
			      		-- Hecker (2005) LEVEL II TECH INDUSTRIES
				      	, '1131', '1132', '2111', '2211', '3251', '3252', '3332'
					, '3333', '3343', '3346', '4234', '5416'
				      	-- Hecker (2005) LEVEL III TECH INDUSTRIES
				      	, '3241', '3253', '3255', '3259', '3336', '3339', '3353'
					, '3369', '4861', '4862', '4869', '5171', '5172', '5173'
					, '5174', '5211', '5232', '5511', '5612', '8112'
				)
		) AS t
		GROUP BY ein
	) AS a
	LEFT JOIN (
		SELECT ein, ssn, quarter
		FROM kcmo_lehd.mo_wage
		WHERE year = 2016
	) AS b
	ON a.ein = b.ein
) AS c
GROUP BY ssn, ein, quarter;


/*
Next, let's create the networks and map on employer names.
*/

-- For Q1 of 2016:
DROP TABLE IF EXISTS ada_kcmo.tech_network_2016_Q1;
CREATE TABLE ada_kcmo.tech_network_2016_Q1 AS
SELECT b.legal_name as legal_name_l
	, a.ein_l
	, a.ssn
	, a.ein_r
	, c.legal_name as legal_name_r
FROM(
	SELECT x.ssn
		, x.ein AS ein_l
		, y.ein AS ein_r
	FROM (SELECT * FROM ada_kcmo.mo_tech_jobs_2016 WHERE quarter = 1) AS x
	JOIN (SELECT * FROM ada_kcmo.mo_tech_jobs_2016 WHERE quarter = 1) AS y
	ON x.ssn = y.ssn
) AS a
LEFT JOIN ada_kcmo.ein_legal_names AS b ON a.ein_l = b.ein
LEFT JOIN ada_kcmo.ein_legal_names AS c ON a.ein_r = c.ein
;
-- Drop self-ties and links without SSN, or legal_name
DELETE FROM ada_kcmo.tech_network_2016_Q1
WHERE ein_l = ein_r 
	OR legal_name_l = legal_name_r 
	OR ein_l = '' OR ein_l IS NULL
	OR ein_r = '' OR ein_r IS NULL
	OR ssn = '' OR ssn IS NULL
	OR legal_name_l = '' OR legal_name_l IS NULL
	OR legal_name_r = '' OR legal_name_r IS NULL;


-- For any quarter of 2016:
DROP TABLE IF EXISTS ada_kcmo.tech_network_2016_anyQ;
CREATE TABLE ada_kcmo.tech_network_2016_anyQ AS
SELECT b.legal_name as legal_name_l
	, a.ein_l
	, a.ssn
	, a.ein_r
	, c.legal_name as legal_name_r
FROM(
	SELECT *
	FROM(
		SELECT x.ssn, x.ein AS ein_l, y.ein AS ein_r
		FROM ada_kcmo.mo_tech_jobs_2016 AS x
		JOIN ada_kcmo.mo_tech_jobs_2016 AS y
		ON x.ssn = y.ssn AND x.quarter = y.quarter
	) AS z
	GROUP BY ssn, ein_l, ein_r
) AS a
LEFT JOIN ada_kcmo.ein_legal_names as b on a.ein_l = b.ein
LEFT JOIN ada_kcmo.ein_legal_names as c on a.ein_r = c.ein
;

DELETE FROM ada_kcmo.tech_network_2016_anyQ
WHERE ein_l = ein_r 
	OR legal_name_l = legal_name_r 
	OR ein_l = '' OR ein_l IS NULL
	OR ein_r = '' OR ein_r IS NULL
	OR ssn = '' OR ssn IS NULL
	OR legal_name_l = '' OR legal_name_l IS NULL
	OR legal_name_r = '' OR legal_name_r IS NULL;


-- For the entire year of 2016:

DROP TABLE IF EXISTS ada_kcmo.tech_network_2016;
CREATE TABLE ada_kcmo.tech_network_2016 AS
SELECT b.legal_name as legal_name_l
	, a.ein_l
	, a.ssn
	, a.ein_r
	, c.legal_name as legal_name_r
FROM(
	SELECT x.ssn
		, x.ein AS ein_l
		, y.ein AS ein_r
	FROM (SELECT ssn, ein FROM ada_kcmo.mo_tech_jobs_2016 GROUP BY ssn, ein) AS x
	JOIN (SELECT ssn, ein FROM ada_kcmo.mo_tech_jobs_2016 GROUP BY ssn, ein) AS y
	ON x.ssn = y.ssn
) AS a
LEFT JOIN ada_kcmo.ein_legal_names AS b ON a.ein_l = b.ein
LEFT JOIN ada_kcmo.ein_legal_names AS c ON a.ein_r = c.ein
;

DELETE FROM ada_kcmo.tech_network_2016
WHERE ein_l = ein_r 
	OR legal_name_l = legal_name_r 
	OR ein_l = '' OR ein_l IS NULL
	OR ein_r = '' OR ein_r IS NULL
	OR ssn = '' OR ssn IS NULL
	OR legal_name_l = '' OR legal_name_l IS NULL
	OR legal_name_r = '' OR legal_name_r IS NULL;

