#packages required
library(dplyr)
library("data.table")
#readdatasetC
majorC <- read.csv("csv_pus/ss16pusc.csv",header=TRUE,stringsAsFactors=FALSE)
#filter out NA values in FOD1P
datasetC <- majorC %>%
  filter(!is.na(FOD1P))

#readmajorlist
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetC <- merge(datasetC, majordata,by = "FOD1P")

#select columns needed for analysis 
resultC <- datasetC %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultC which is datasetC with columns needed for analysis
write.csv(resultC, "resultC.csv", row.names = FALSE)
