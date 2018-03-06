#packages required
library(dplyr)
library("data.table")
#readdatasetD
majorD <- read.csv("csv_pus/ss16pusd.csv",header=TRUE,stringsAsFactors=FALSE)
#filter out NA values in FOD1P
datasetD <- majorD %>%
  filter(!is.na(FOD1P))

#readmajorlist
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetD <- merge(datasetD, majordata,by = "FOD1P")

#select columns needed for analysis 
resultD <- datasetD %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultD which is datasetD with columns needed for analysis
write.csv(resultD, "resultD.csv", row.names = FALSE)
