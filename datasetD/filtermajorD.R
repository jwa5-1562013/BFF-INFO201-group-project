library("data.table")
library("dplyr")

majorD <- fread("csv_pus/ss16pusd.csv")
datasetD <- majorD %>%
  filter(!is.na(FOD1P))
#write csv datasetD with no-NA majors
write.csv(datasetD, "majorD.csv", row.names=FALSE)
#reopen r and only runs dplyr package
datasetD <- read.csv("majorD.csv", header=TRUE,stringsAsFactors=FALSE)
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)
#merge data with majorlist
datasetD <- merge(datasetD, majordata,by = "FOD1P")
#merged data with major
write.csv(datasetD, "datasetD.csv", row.names=FALSE)

resultD <- datasetD %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultD which is datasetD with columns needed for analysis
write.csv(resultD, "resultD.csv", row.names = FALSE)
