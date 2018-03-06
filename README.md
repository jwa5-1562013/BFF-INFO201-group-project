# Group project: College Majors
  
  This project uses a dataset from 2012 to 2016 containing information of employment, earnings, sex, college majors, etc., and analysis the relationship between college majors and earnings. 
  
  Our goal is to help college students either with a major or haven't decided one to have a better idea of the economic aspect of their degrees. 
  
  The idea was inspired by the article “The Economic Guide to Picking a College Major” by Ben Casselman.

  All data is from **American Community Survey 2012-2016 Public Use Microdata Series (ACS-PUMS)**, collected by the United States Census Bureau.

  Download data here: [http://www.census.gov/programs-surveys/acs/data/pums.html](http://www.census.gov/programs-surveys/acs/data/pums.html)

  
  
  After downloading the data which contain 4 `.csv` files, we select only records with non-NA values for college majors(FOD1P) and columns of information we need for analysis, then merge data with college major list and combine these 4 `.csv` files into one. After that, we group the data by different majors and summarize their median earnings and employment rate and so on. 
  
  The `filtermajor.R` in each dataset contains the code we used to filter and merge data files.    
  The `data-processing.R` contains the code we used to filter and group data files, it also contains code used to generate the final result table.

 
 four main data results:  
    `Allages.csv`  (All ages and all genders with Bachelor's degrees)  
    `gradstudent.csv` (All ages and all genders with Master's degrees)    
    `female.csv` (Females of all ages with Bachelor's degrees)  
    `male.csv` (Males of all ages with Bachelor's degrees)  
 
  All datas contain basic information like **Median earnings**, **25th percentile of earnigns**, **75th percentile of earnings**, **employment**, **unemploy rate**, etc.. 