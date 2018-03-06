#packages required
library(dplyr)
library("data.table")
#readdatasetB
majorB <- read.csv("csv_pus/ss16pusb.csv",header=TRUE,stringsAsFactors=FALSE)
#filter out NA values in FOD1P
datasetB <- majorB %>%
  filter(!is.na(FOD1P))

#readmajorlist
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetB <- merge(datasetB, majordata,by = "FOD1P")

#select columns needed for analysis 
resultB <- datasetB %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultB which is datasetB with columns needed for analysis
write.csv(resultB, "resultB.csv", row.names = FALSE)
