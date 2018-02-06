# Notes on data:

## LODES:

- Description:
  + Bloc level data counts of workers

- Geographic level:
  + Block level
  + Crosswalk file maps block to county, city, metropolitan area, etc.
    + But not Workforce Investment Area!

- Necessary files:
  + MAIN: only workers who work and live in the state
  + AUX: Also consider workers from outside of state who work in state
  + JT00: All type of jobs (can be split by primary, private, federal, etc.)
  + S000: Total number of jobs (can be split by age, wage, industry)

  => mo_od_main_JT00_2015.csv (Origin-Destination main file)
  => mo_od_aux_JT00_2015.csv (Origin-Destination aux file)
  => mo_rac_s000_JT00_2015.csv (Residence Area Characteristics)
  => mo_wac_s000_JT00_2015.csv (Workplace Area Characteristics)
  => mo_xwalk.csv (crosswalk from block to other geographies)

- Origin-Destination Main File:
  + Number of observations: 2'290'142 (Residence_blocks * Workplace_blocks, when non-null!)
  + Number of overall jobs (S000): very scarce, 75th percentile is still 1, mean 1.09.
  + Same for subcategories (jobs by age, earnings, industry
- Origin-Destination Aux File:
  + Number of observations: 221'295 (Non_MO_Residence_blocks * Workplace_blocks, when non-null)
  + Number of jobs: very scare
- Combining both O-D files:
  + MAIN and AUX file can be stacked
  + Total of 2'713'826 jobs (same as WAC file)
    + AUX file represents about 1% of jobs

- Residence Area Characteristics
  + Number of observations: 163'413 (Residence_blocks when non-null)
  + Number of overall jobs (C000): mean of 16
  + Subsets of jobs by age, earnings, NAICS industry code, ethnicity, education, sex
  + Total number of jobs: 2,685,392 (less than other datasets)

- Workplace Area Characteristics
  + Number of observations: 53,112 (Workplace_blocks when non-null)
  + Number of overall jobs (C000): mean of 51 (more density than for residential blocks)
  + Subsets of jobs by age, earnings, NAICS industry code, ethnicity, education, sex
  + Total number of jobs: 2,713,826 (same as O-D datasets)

- Geographic Crosswalk File:
  + 343,565 blocks (many therefore with neither residents nor workers)



## Quarterly Workforce Indicator (QWI):

- Description:
  + Geographic labor statistics

- Geographic level:
  + Most granular seems to be Workforce Investment Area but this is not mappable to block!
  + Most useful probably Metropolitan Area

- Necessary files:
  + GM: Metropolitan level
  + NS: NAICS industry sectors (there are other industry categorizations as well)
  + F: firm age and size not included (can be additional information for further groups)

  => qwi_mo_sa_f_gm_ns_oslp_u.csv (sex by age)
  => qwi_mo_rh_f_gm_ns_oslp_u.csv (race by ethnicity)
  => qwi_mo_se_f_gm_ns_oslp_u.csv (sex by education)

- Sex by Age:
  + Statistics are for every year, quarter, geography, industry, sex, and age group.
    + 567 observations per year, quarter, geography (9 age_groups * 21 industries * 3 sexes)
  + There is an overall industry category (code 00) which *ALMOST* sums the other categories
  



## Linking datasets:

- LODES data and QWI Metropolitan Area data can be linked by Metropolitan Area.
  + There is a small manipulation to do: On the LODES metropolitan areas are noted with a 5 digit number, on the QWI there is a state prefix (29)
