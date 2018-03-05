#packages required
library("dplyr")
majorA <- read.csv("datasetA/majorA.csv",header=TRUE,stringsAsFactors=FALSE)
majordata <- read.csv("csv_pus/majors-list.csv",header=TRUE,stringsAsFactors=FALSE)

#merge datasets
datasetA <- merge(majorA, majordata,by = "FOD1P")
 
test <- datasetA %>%
        select(SCHL)
        

datasetA$FTYR <- 0
datasetA$FTYR[datasetA$WKW == 1 & datasetA$WKHP >= 35] <- 1
nrow(datasetA[datasetA$FTYR==1,])


allage <- filter(datasetA,SCHL == 21) # No grad degree earners
allage.ftyr <- filter(datasetA,SCHL == 21 & FTYR == 1 & PERNP >0)
over25.nograd <- filter(datasetA,AGEP > 24 & SCHL == 21)
over25.grad <- filter(datasetA,AGEP > 24 & SCHL > 21)
young <- filter(datasetA,AGEP < 28) # This DOES include students with grad degrees
young.ftyr <- filter(young,FTYR == 1 & SCHL == 21 & SCH == 1) # But this doesn't. Also excludes those in school.

lowend <- c(4020,4030,4040,4050,4060,4110,4120,4130,4140,4150,4220,4230,4240,4250,4720,4740,4750,4760,4940)
young$LowEnd  <-  0
young$LowEnd[young$OCCP10 %in% as.list(lowend) | young$OCCP12 %in% as.list(lowend)] <- 1

AllAges <- data.frame(FOD1P = as.numeric(majordata$FOD1P[2:nrow(majordata)]),Major = majordata$Major[2:nrow(majordata)],Major_Cat = majordata$Major_Category[2:nrow(majordata)],
                      Total = NA, Employed = NA, FTYR = NA, Unemployed = NA, Urate = NA, Median = NA, P25th = NA, P75th = NA)
Ages25up <- data.frame(FOD1P = as.numeric(majordata$FOD1P[2:nrow(majordata)]),Major = majordata$Major[2:nrow(majordata)],Major_Cat = majordata$Major_Category[2:nrow(majordata)],
                       GradTotal = NA, GradEmployed = NA, GradFTYR = NA, GradUnemployed = NA, GradUrate = NA, GradMedian = NA, GradP25th = NA, GradP75th = NA,GradSample = NA,
                       NoGradTotal = NA, NoGradEmployed = NA, NoGradFTYR = NA, NoGradUnemployed = NA, NoGradUrate = NA, NoGradMedian = NA, NoGradP25th = NA, NoGradP75th = NA)
Young <- data.frame(FOD1P = as.numeric(majordata$FOD1P[2:nrow(majordata)]),Major = majordata$Major[2:nrow(majordata)],Major_Cat = majordata$Major_Category[2:nrow(majordata)],
                    Total = NA, Employed = NA, FTYR = NA, Unemployed = NA, Urate = NA, Median = NA, P25th = NA, P75th = NA, Sample = NA,
                    Median_hours = NA, FT = NA, PT = NA, LowEnd = NA, CollegeJob = NA, NonCollege = NA, Men = NA, Women = NA, ShareWomen = NA)

loop <- seq(1:nrow(AllAges))
for (i in loop) {
  x <- AllAges$FOD1P[i]
  AllAges[i,4] <- with(allage,sum(PWGTP[FOD1P==x]))
  AllAges[i,5] <- with(allage,sum(PWGTP[FOD1P==x & (ESR == 1 | ESR == 2)]))
  AllAges[i,6] <- with(allage,sum(PWGTP[FOD1P==x & FTYR == 1]))
  AllAges[i,7] <- with(allage,sum(PWGTP[FOD1P==x & ESR == 3]))
  AllAges[i,8] <- AllAges[i,7]/(AllAges[i,5] + AllAges[i,7])
  AllAges[i,9] <- with(allage.ftyr[allage.ftyr$FOD1P == x,],median(rep(PERNP,times=PWGTP)))
  AllAges[i,10] <- with(allage.ftyr[allage.ftyr$FOD1P == x,],quantile(rep(PERNP,times=PWGTP))[2])
  AllAges[i,11] <- with(allage.ftyr[allage.ftyr$FOD1P == x,],quantile(rep(PERNP,times=PWGTP))[4])
  
  Ages25up[i,4] <- with(over25.grad,sum(PWGTP[FOD1P==x]))
  Ages25up[i,5] <- with(over25.grad,sum(PWGTP[FOD1P==x & (ESR == 1 | ESR == 2)]))
  Ages25up[i,6] <- with(over25.grad,sum(PWGTP[FOD1P==x & FTYR == 1]))
  Ages25up[i,7] <- with(over25.grad,sum(PWGTP[FOD1P==x & ESR == 3]))
  Ages25up[i,8] <- Ages25up[i,7]/(Ages25up[i,5] + Ages25up[i,7])
  Ages25up[i,9] <- with(over25.grad[over25.grad$FOD1P == x & over25.grad$FTYR ==1,],median(rep(PERNP,times=PWGTP)))
  Ages25up[i,10] <- with(over25.grad[over25.grad$FOD1P == x & over25.grad$FTYR ==1,],quantile(rep(PERNP,times=PWGTP))[2])
  Ages25up[i,11] <- with(over25.grad[over25.grad$FOD1P == x & over25.grad$FTYR ==1,],quantile(rep(PERNP,times=PWGTP))[4])
  Ages25up[i,12] <- nrow(over25.grad[over25.grad$FOD1P == x & over25.grad$FTYR ==1,])
  Ages25up[i,13] <- with(over25.nograd,sum(PWGTP[FOD1P==x]))
  Ages25up[i,14] <- with(over25.nograd,sum(PWGTP[FOD1P==x & (ESR == 1 | ESR == 2)]))
  Ages25up[i,15] <- with(over25.nograd,sum(PWGTP[FOD1P==x & FTYR == 1]))
  Ages25up[i,16] <- with(over25.nograd,sum(PWGTP[FOD1P==x & ESR == 3]))
  Ages25up[i,17] <- Ages25up[i,16]/(Ages25up[i,14] + Ages25up[i,16])
  Ages25up[i,18] <- with(over25.nograd[over25.nograd$FOD1P == x & over25.nograd$FTYR ==1,],median(rep(PERNP,times=PWGTP)))
  Ages25up[i,19] <- with(over25.nograd[over25.nograd$FOD1P == x & over25.nograd$FTYR ==1,],quantile(rep(PERNP,times=PWGTP))[2])
  Ages25up[i,20] <- with(over25.nograd[over25.nograd$FOD1P == x & over25.nograd$FTYR ==1,],quantile(rep(PERNP,times=PWGTP))[4])  
  
  Young[i,4] <- with(young,sum(PWGTP[FOD1P==x]))
  Young[i,5] <- with(young,sum(PWGTP[FOD1P==x & (ESR == 1 | ESR == 2)]))
  Young[i,6] <- with(young,sum(PWGTP[FOD1P==x & FTYR == 1]))
  Young[i,7] <- with(young,sum(PWGTP[FOD1P==x & ESR == 3]))
  Young[i,8] <- Young[i,7]/(Young[i,5] + Young[i,7])
  Young[i,9] <- with(young.ftyr[young.ftyr$FOD1P == x & young.ftyr$PERNP>0,],median(rep(PERNP,times=PWGTP)))
  Young[i,10] <- with(young.ftyr[young.ftyr$FOD1P == x & young.ftyr$PERNP>0,],quantile(rep(PERNP,times=PWGTP))[2])
  Young[i,11] <- with(young.ftyr[young.ftyr$FOD1P == x & young.ftyr$PERNP>0,],quantile(rep(PERNP,times=PWGTP))[4])
  Young[i,12] <- nrow(young.ftyr[young.ftyr$FOD1P == x & young.ftyr$PERNP>0,])
  Young[i,13] <- with(young[young$FOD1P == x,],median(na.omit(rep(WKHP,times=PWGTP))))
  Young[i,14] <- with(young,sum(na.omit(PWGTP[FOD1P==x & WKHP >= 35])))
  Young[i,15] <- with(young,sum(na.omit(PWGTP[FOD1P==x & WKHP < 35])))
  Young[i,16] <- with(young,sum(PWGTP[FOD1P==x & LowEnd == 1]))
  Young[i,17] <- with(young,sum(na.omit(PWGTP[FOD1P==x & collegejob == 1 & (ESR == 1 | ESR == 2)]))) # only want employed
  Young[i,18] <- with(young,sum(na.omit(PWGTP[FOD1P==x & noncollege == 1 & (ESR == 1 | ESR == 2)]))) # only want employed
  Young[i,19] <- with(young,sum(PWGTP[FOD1P==x & SEX == 1]))
  Young[i,20] <- with(young,sum(PWGTP[FOD1P==x & SEX == 2]))
  Young[i,21] <- Young[i,20]/(Young[i,19] + Young[i,20])
  
  print(paste(i,"of",nrow(AllAges)))
}

write.csv(Young,file="Young.csv")
write.csv(AllAges,file="AllAges.csv")
write.csv(Ages25up,file="Ages25up.csv")
