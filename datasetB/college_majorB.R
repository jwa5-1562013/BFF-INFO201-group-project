library("dplyr")
majorB <- read.csv("datasetB/majorB.csv",header=TRUE,stringsAsFactors=FALSE)
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetB <- merge(majorB, majordata,by = "FOD1P")
#merged data with major
write.csv(datasetB, "datasetB.csv", row.names=FALSE)
