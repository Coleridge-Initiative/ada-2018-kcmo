/*
First, let's subset the wage record data to High Tech industries.
Using the list of High Tech Industry NAICS codes developed by Hecker (2005), we restrict the employer data to those in Technology Industries. We then merge the wage data onto this subset in order to keep only EINs associated with High Tech NAICS codes.
The resulting table is saved in the KCMO_ada schema.
*/

\echo "Munging The Data"


CREATE TABLE IF NOT EXISTS kcmo_ada.mo_tech_wage_2016 AS
SELECT *
FROM (
  SELECT a.ein, b.ssn, b.quarter
  FROM (
    SELECT *
    FROM (
      SELECT ein
      FROM kcmo_lehd.mo_qcew_employers
      WHERE year = 2016
            AND left(naics, 4) in (
              --LEVEL I TECHNOLOGY INDUSTRIES
              3254, 3341, 3342, 3344, 3345, 3364, 5112, 5161, 5179, 5181, 5182, 5413, 5415, 5417
              --LEVEL II TECHNOLOGY INDUSTRIES
              , 1131, 1132, 2111, 2211, 3251, 3252, 3332, 3333, 3343, 3346, 4234, 5416
              --LEVEL III TECHNOLOGY INDUSTRIES
              , 3241, 3253, 3255, 3259, 3336, 3339, 3353, 3369, 4861, 4862, 4869
              , 5171, 5172, 5173, 5174, 5211, 5232, 5511, 5612, 8112
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
Next, let's create the networks.
*/

\echo "making the networks"

CREATE TABLE if NOT EXISTS kcmo_ada.tech_network_2010_Q1 AS
SELECT a.ssn
        , a.ein AS ein_l
        , b.ein AS ein_r
FROM kcmo_ada.mo_tech_wage_2016 (where quarter = 1) AS a
JOIN kcmo_ada.mo_tech_wage_2016 (where quarter = 1) AS b
ON a.ssn = b.ssn;

DELETE FROM kcmo_ada.tech_network_2010_Q1
WHERE ein_l = ein_r OR ssn = '';



CREATE TABLE if NOT EXISTS kcmo_ada.tech_network_2010_anyQ AS
SELECT *
FROM(
  SELECT a.ssn
          , a.ein AS ein_l
          , b.ein AS ein_r
  FROM kcmo_ada.mo_tech_wage_2016 AS a
  JOIN kcmo_ada.mo_tech_wage_2016 AS b
  ON a.ssn = b.ssn AND a.quarter = b.quarter;
) AS a
GROUP BY ssn, ein_l, ein_r

DELETE FROM kcmo_ada.tech_network_2010_anyQ
WHERE ein_l = ein_r OR ssn = '';



CREATE TABLE if NOT EXISTS kcmo_ada.tech_network_2010 AS
SELECT a.ssn
        , a.ein AS ein_l
        , b.ein AS ein_r
FROM (SELECT ssn, ein FROM kcmo_ada.mo_tech_wage_2016 GROUP BY ssn, ein) AS a
JOIN (SELECT ssn, ein FROM kcmo_ada.mo_tech_wage_2016 GROUP BY ssn, ein) AS b
ON a.ssn = b.ssn AND a.quarter = b.quarter;

DELETE FROM kcmo_ada.tech_network_2010
WHERE ein_l = ein_r OR ssn = '';



\echo "mapping on employer legal name"

DROP TABLE IF EXISTS kcmo_ada.ein_name;
CREATE TABLE kcmo_ada.ein_name AS
SELECT ein
        , legal_name
        , count(*) as count
from kcmo_lehd.mo_qcew_employers
group by ein, legal_name
order by ein, count desc;

DROP TABLE IF EXISTS ada_class3.ein_network_2015;
CREATE TABLE ada_class3.ein_network_2015 AS
SELECT n.ssn_l, n.ein, e.name_legal, n.ssn_r
FROM ada_class3.ein_network n
JOIN ada_class3.ein_name e ON n.ein = e.ein;

DELETE FROM ada_class3.ein_network_2015
WHERE name_legal = 'nan';
