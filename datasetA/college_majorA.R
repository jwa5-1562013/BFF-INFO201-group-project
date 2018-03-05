#install packages 
library("data.table")
library("dplyr")

datasetA <- fread("datasetA.csv")

#filter basic columns needed
result <- datasetA %>%
          select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)
#
