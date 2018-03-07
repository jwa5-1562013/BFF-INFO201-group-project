# Group project: College Majors

  This project uses data from **American Community Survey 2012-2016 Public Use Microdata Series (ACS_PUMS)**, collected by the United States Census Bureau. The PUMS files include population and housing unit records with individual response such as relationship, sex, educational attainment, and employment status. The data do not contain names, addresses, or any information that may breach confidentiality.

  The project was inspired by the article "[The Economic Guide to Picking a College Major](https://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/)", in which the relationship between the college majors and earnings is discussed with the 2010-2012 PUMS data from the same source.  

  Shiny app is used to present our analysis, in which we compare how the median earnings have shifted in the last 5 years. In addition, we look to answer several questions that may be of interest to all *students*, regardless of whether they have already chosen a major or not:
* **_How much can a student expect to receive right upon graduation in his or her major?_**
* **_By how much is the student's earning likely to grow over the years in his or her field?_**
* **_How worth is it to pursue a graduate school degree in the specified major?_**

We also explored whether there is a correlation between gender and earnings.


Download data here:
[http://www.census.gov/programs-surveys/acs/data/pums.html](http://www.census.gov/programs-surveys/acs/data/pums.html)

Documentation here: [http://www.census.gov/programs-surveys/acs/technical-documentation/pums.html](http://www.census.gov/programs-surveys/acs/technical-documentation/pums.html)

`data_processing.R`
* Takes in the original data and select only records with non-NA values for college major(FOD1P)
* Outputs data to multiple csv files to be used in the analysis

`data_analysis.R`
* Compiles relevant data into 4 different data frames for 4 different analyses

Main data files:
* `all.csv`: only bachelor's degree & all age
* `recent_grads.csv`: only bachelor's degree & age <28 (2012-2016)
* `grad_degree.csv`: higher than bachelor's degree
* `recent_grads_2010_2012.csv`: only bachelor's degree & age <28 (2010-2012). Source: [Economic Guide To Picking A College Major GitHub link](https://github.com/fivethirtyeight/data/tree/master/college-majors)
* `majors_list`: list of majors with their FOD1P codes and major categories. Source: ["What's It Worth?: The Economic Value of College Majors." Georgetown University Center on Education and the Workforce, 2011.](http://cew.georgetown.edu/whatsitworth)


  The `.csv` files contain headers such as: `Major`, `Major_Category`, `total_majors`, `employed`, `unemployed`, `mean_earnings`, `median_earnings`, `quantile(0.25)`, `quantile(0.75)`, and `unemployment_rate`

Shiny app URL: https://wenqih.shinyapps.io/BFF-INFO201-group-project/
