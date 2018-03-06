#packages required
library(dplyr)
library("data.table")
#readdatasetA
majorA <- read.csv("csv_pus/ss16pusa.csv",header=TRUE,stringsAsFactors=FALSE)
#filter out NA values in FOD1P
datasetA <- majorA %>%
  filter(!is.na(FOD1P))

#readmajorlist
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetA <- merge(datasetA, majordata,by = "FOD1P")

#select columns needed for analysis 
resultA <- datasetA %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultA which is datasetA with columns needed for analysis
write.csv(resultA, "resultA.csv", row.names = FALSE)
