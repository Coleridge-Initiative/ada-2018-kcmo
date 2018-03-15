# Notes on data:

## LODES:
- Description:
  + Bloc level data counts of workers
- Geographic level:
  + Block level
  + Crosswalk file maps block to county, city, metropolitan area, etc.
- File Name:
  + MAIN: only workers who work and live in the state
  + AUX: Also consider workers from outside of state who work in state
  + JT00: All type of jobs (can be split by primary, private, federal, etc.)
  + S000: Total number of jobs (can be split by age, wage, industry)
  + S001: Primary jobs (can be split by age, wage, industry)
    - *Why primary jobs only?*
- OD data:
- RAC data:
- WAC data:
  + *No sex, race, education, firm age information before 2009*
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

## KCMO Business Licenses:
- Variable Names:
  + ['business_activity', 'address', 'legal_name', 'dba_name', 'filing_period']


## Wage Records Data
- Latitude and Longitude were not properly parsed
  + Check if the first character was not incorrectly parsed
- *Ezra will be matching Wage records from MO and IL*
- EIN is consistent across states within companies that do not work with franchises
  + EIN can be 1, 2, 7, 8 digit – should be 9
    - LOOK INTO !
  + Names are not useful – only in some rare cases
  + Most firm will not match across states
- Sub-EIN: useful for the zip-code
