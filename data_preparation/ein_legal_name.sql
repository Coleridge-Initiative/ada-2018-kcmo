-- EIN LEGAL NAMES STUFF

CREATE TABLE if NOT EXISTS ada_kcmo.ein_legal_names AS
SELECT ein, legal_name
FROM (
	SELECT ein, legal_name, count, ROW_NUMBER() OVER (PARTITION BY ein ORDER BY count DESC) AS rank
	FROM (
		SELECT ein, legal_name, COUNT(*) AS count
		FROM kcmo_lehd.mo_qcew_employers
		GROUP BY ein, legal_name
	) AS ein_name_freq
) AS ein_name_freq
WHERE rank = 1 AND ein != ''
ORDER BY ein;



