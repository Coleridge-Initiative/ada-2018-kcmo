# Overview of all notebooks
- Two ways of connecting to database
  + To clarify with Jonathan: do we want to show them both, why
  + If we have to use both, put them both in the first notebook
  + If one, SQL Alchemy is preferred

## 1_3_Variables
- First example of combining Python and SQL: Most of the content is good
- LEHD data will be used
- *What should the exercise be?*
  + Do for LODES, ask to do the same for water services (or patents, or business licenses)
  1. __What are the datasets?__
    + Primary class datasets will already be in the database
    + Also, read descriptions in ADRF explorer (make sure the Explorer is populated correctly and that people can access it)
  2. Give simple statistics for datasets
  3. Combine datasets in some kind of way
    + Subset to KCMO by Merging on X-walk (JOIN and WHERE)
  4. Show some kind of correlation/table combining 2 variable from different datasets
    + Combining Lodes and water data

## 2_1_Database_clients
- Remove section on the command line
- Rest is still relevant
- Change connection to database

## 2_2_APIs
- Done: using patent numbers to get patent description on PatentsView API.
- *This notebook has to be moved to after Record Linkage.*
- Removed: Routing API, Geocoding, Isochrone API,
- Removed? *Incorporating databases*

## 2_3_data_visualization
- Keep as is
- Near the middle *I need inspiration for the graphs!! Water data perhaps?*
- *seaborn function tsplot is deprecated – replace?*
- Need inspiration for the exercises

## 3_1_Record_Linkage
- Focus on linking companies from KCMO dataset to Patent dataset to water services data
- Data exploration: look at both business name formats
- Preprocessing: cleaning out legal names in both with RegEx
- Matching: matching the name of the companies
  + Exact matching is easy (on company name and on address)
  + Fuzzy matching more complex: *what other features should be considered?*
- Three types of matching are exact, rule-based and probabilistic. *Should fuzzy matching be treated separately?*
- *TO DO: Review on the methods of record linkage, after standardization and cleaning.*

## 4_1_Text_Analysis
- on patent abstract
- *Are the functions defined too early in the notebook? Separated?* I would do entire run without functions, then say: let's recap everything into 3 functions, that you can keep for other projects.
- *Is it worth showing N-grams?* The results are not particularly relevant here... But useful in general
- *Can we remove Supervised Learning?* We would have to find a new way of doing it here (there is not the factype variable that we need)
- I removed import progressbar

## 4_2_Network Analysis
- Use patent data
  + *NOT CLEAR WHAT DATA TO USE HERE.*
  + *Patent data? Inventors going from one company to another? Or moving around areas?*

## 5_1_Machine_Learning
- Wait for feedback from Rayid on how he wants to run this

## 6_1_Machine_Learning_Recap
- Same as above

## 7_1_Inference_Data_Setup
-
