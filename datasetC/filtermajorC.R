library("data.table")
library("dplyr")

majorC <- fread("csv_pus/ss16pusc.csv")
datasetC <- majorC %>%
            filter(!is.na(FOD1P))
#write csv datasetC with no-NA majors
write.csv(datasetC, "majorC.csv", row.names=FALSE)
#reopen r and only runs dplyr package
datasetC <- read.csv("majorC.csv", header=TRUE,stringsAsFactors=FALSE)
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)
#merge data with majorlist
datasetC <- merge(datasetC, majordata,by = "FOD1P")
#merged data with major
write.csv(datasetC, "datasetC.csv", row.names=FALSE)

resultC <- datasetC %>%
  select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP,WKHP)

#write resultC which is datasetC with columns needed for analysis
write.csv(resultC, "resultC.csv", row.names = FALSE)
