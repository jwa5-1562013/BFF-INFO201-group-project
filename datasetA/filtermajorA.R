#packages required
library("dplyr")
majorA <- read.csv("datasetA/majorA.csv",header=TRUE,stringsAsFactors=FALSE)
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetA <- merge(majorA, majordata,by = "FOD1P")
result <- datasetA %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

write.csv(result, "resultA.csv", row.names=FALSE)



