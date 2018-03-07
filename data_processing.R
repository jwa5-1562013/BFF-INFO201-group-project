#install packages
library("dplyr")
library("data.table")
library("bit64")

## ORIGINAL DATA PROCESSING
#########################################################################################################

## Original data not on github due to its size. Can be downloaded as four files from:
## http://www.census.gov/programs-surveys/acs/data/pums.html

# pus_a <- fread("csv_pus/ss16pusa.csv", header = TRUE, stringsAsFactors = FALSE)
# pus_b <- fread("csv_pus/ss16pusb.csv", header = TRUE, stringsAsFactors = FALSE)
# pus_c <- fread("csv_pus/ss16pusc.csv", header = TRUE, stringsAsFactors = FALSE)
# pus_d <- fread("csv_pus/ss16pusd.csv", header = TRUE, stringsAsFactors = FALSE)

majors_list <- read.csv("data/majors_list.csv", header = TRUE, stringsAsFactors = FALSE)

filterMergeMajor <- function(pus_data, majors_list, file_name) {
  pus_data <- filter(pus_data, !is.na(FOD1P)) # filter data with major info
  subset <- merge(pus_data, majors_list, by = "FOD1P") %>% # match FOD1P coded majors to readable form
    select(FOD1P, Major, Major_Category, SEX, AGEP, SCH, SCHL, ESR, PERNP, WKHP)
  write.csv(subset, file_name, row.names = FALSE)
}

# Performed on the remote server due to large memory required to process data
# filterMergeMajor(pus_a, majors_list, "data/resultA")
# filterMergeMajor(pus_b, majors_list, "data/resultB")
# filterMergeMajor(pus_c, majors_list, "data/resultC")
# filterMergeMajor(pus_d, majors_list, "data/resultD")

# Clear workspace to conserve memory
rm(list = ls())




## COMPILING RELEVANT DATA
#########################################################################################################

# Read separated data files 
resultA <- fread(file = "data/resultA.csv", stringsAsFactors = FALSE, header = TRUE)
resultB <- fread(file = "data/resultB.csv", stringsAsFactors = FALSE, header = TRUE)
resultC <- fread(file = "data/resultC.csv", stringsAsFactors = FALSE, header = TRUE)
resultD <- fread(file = "data/resultD.csv", stringsAsFactors = FALSE, header = TRUE)

# Merge four files into one
results.df <- rbind(resultA, resultB, resultC, resultD)

# ESR(employment status) is represented by:
# 1: employed, 2: employed but not at work, 3: unemployed, 4,5,6: other conditions
results.df$EMPLOYMENT <- ifelse(results.df$ESR == 1 | results.df$ESR == 2 , 1, 0)

# WKHP is Usual hours worked per week past 12 months.
# If greater than 35, a full-time job. Otherwise, a part-time job
results.df$FULLORPART <- ifelse(results.df$WKHP > 35, 1, 0)

#ESR(employment status) of 3 is unemployed
results.df$UNEMPLOYED <- ifelse(results.df$ESR == 3, 1, 0)

rm(list=setdiff(ls(), "results.df"))


## CREATING DATASETS TO BE USED FOR COMPARISON ANALYSES
#########################################################################################################

# All ages with only a bachelor's degree
all.ages <- filter(results.df, results.df$SCHL == 21)

# Recent grads (age < 28) with only a bachelors degree
recent.grads <- filter(results.df, results.df$AGEP < 28 & results.df$SCHL == 21)

# Females with only a bachelor's degree 
female <- filter(results.df, results.df$SEX == 2 & results.df$SCHL == 21)

# Males with only a bachelor's degree 
male <- filter(results.df, results.df$SEX == 1 & results.df$SCHL == 21)

# Those with above a bachelor's degree (Master's, Professional or Doctorate degrees)
grad.degree <- filter(results.df, results.df$SCHL > 21)

# Summarize employment statistics
summarizeMajor <- function(df) { 
  group_by(df, Major, Major_Category) %>%
    summarise(
    total_majors  = n(),
    employed = sum(EMPLOYMENT == 1 ),
    unemployed = sum(UNEMPLOYED == 1) 
    )
}

#Summarize earning statistics
summarizeEarnings <- function(df) { 
  group_by(df, Major, Major_Category) %>%
    filter(EMPLOYMENT != 0) %>%
    summarise(
      mean_earnings = mean(PERNP),
      median_earnings = median(PERNP),
      quantile(PERNP, .25),
      quantile(PERNP, .75)
    )
}

summaryByMajor <- function(df, file_name) {
  merge(summarizeMajor(df), summarizeEarnings(df), by = c("Major", "Major_Category")) %>%
  mutate(unemployment_rate = round(unemployed / employed * 100, 1)) %>% 
  write.csv(file_name, row.names = FALSE)
}

summaryByMajor(all.ages, "all.csv")
summaryByMajor(recent.grads, "recent_grads.csv")
summaryByMajor(male, "male.csv")
summaryByMajor(female, "female.csv")
summaryByMajor(grad.degree, "grad_degree.csv")



