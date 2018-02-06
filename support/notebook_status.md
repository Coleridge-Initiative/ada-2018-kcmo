# Overview of all notebooks
- *Should we rename LODES variables?*


## 1_3_Variables
- First example of combining Python and SQL: Most of the content is good
- LEHD data will be used
- What should the exercise be?

## 1_4_Variables_Exercices
- Exercise structure is still relevant
- *What should the dataset be?*

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
- *Is it worth showing N-grams?* The results are not particularly relevant here.
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
