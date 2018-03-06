library("dplyr")
library("data.table")
library("bit64")

# Take in Results 
resultA <- fread(file = "resultA.csv", stringsAsFactors = FALSE, header = TRUE)
resultB <- fread(file = "resultB.csv", stringsAsFactors = FALSE, header = TRUE)
resultC <- fread(file = "resultC.csv", stringsAsFactors = FALSE, header = TRUE)
resultD <- fread(file = "resultD.csv", stringsAsFactors = FALSE, header = TRUE)

results.df <- rbind(resultA, resultB, resultC, resultD)

# 1&2 are employed, 3 are unemployed, 4-6 are not considered
results.df$EMPLOYMENT <- ifelse(results.df$ESR == 1 | results.df$ESR == 2 , 1, 0)

results.df$FULLORPART <- ifelse(results.df$WKHP > 35, 1, 0)

results.df$UNEMPLOYED <- ifelse(results.df$ESR == 3, 1, 0)



# All ages with a bachelors degree
all.ages <- filter(results.df, results.df$SCHL == 21)

# Those with above a bachelors degree 
grad.degree <- filter(results.df, results.df$SCHL > 21)

# Females with bachelors degree 
female <- filter(results.df, results.df$SEX == 2 & results.df$SCHL == 21)

# Males with bachelors degree 
male <- filter(results.df, results.df$SEX == 1 & results.df$SCHL == 21)










# Summarize employment statistics

summarizeFunction <- function(df) { 
  group_by(df, Major) %>%
    summarise(
    total_majors  = n(),
    number_employed = sum(EMPLOYMENT == 1 ),
    number_unemployed = sum(UNEMPLOYED == 1) 

    )
  
}

#Summarize earning statistics
summarizeEarningsFunction <- function(df) { 
  group_by(df, Major) %>%
    filter(EMPLOYMENT != 0) %>%
    summarise(
      mean_earnings = mean(PERNP),
      median_earnings = median(PERNP),
      two.five <- quantile(PERNP, .25),
      seven.five <- quantile(PERNP, .75)
    )
  
}


# Summarized by major 
male.employment.sum <- summarizeFunction(male)
female.employment.sum <- summarizeFunction(female)
grad.employment.sum <- summarizeFunction(grad.degree)
all.ages.employment.sum <- summarizeFunction(all.ages)

male.earnings.sum <- summarizeEarningsFunction(male)
female.earnings.sum <- summarizeEarningsFunction(female)
grad.earnings.sum <- summarizeEarningsFunction(grad.degree)
all.ages.earnings.sum <- summarizeEarningsFunction(all.ages)

total.male.sum <- merge(male.earnings.sum,male.employment.sum, by = "Major")
total.female.sum <- merge(female.earnings.sum,female.employment.sum, by = "Major")
total.grad.sum <- merge(grad.earnings.sum,grad.employment.sum, by = "Major")
total.all.ages.sum <- merge(all.ages.earnings.sum,all.ages.employment.sum, by = "Major")

total.male.sum$unemployment_rate <- round((total.male.sum$number_unemployed / total.male.sum$number_employed) * 100, 1)
total.female.sum$unemployment_rate <- round((total.female.sum$number_unemployed / total.female.sum$number_employed) *100, 1)
total.grad.sum$unemployment_rate <- round((total.grad.sum$number_unemployed/ total.grad.sum$number_unemployed) * 100, 1 )
total.all.ages.sum$unemployment_rate <- round((total.all.ages.sum$number_unemployed / total.all.ages.sum$number_employed) * 100, 1)

write.csv(total.male.sum, file = "major-data-sum/sum-male.csv", row.names = FALSE )
write.csv(total.female.sum, file = "major-data-sum/sum-female.csv", row.names = FALSE)
write.csv(total.grad.sum, file = "major-data-sum/sum-grad.csv", row.names = FALSE)
write.csv(total.all.ages.sum, file = "major-data-sum/sum-all.csv", row.names = FALSE)

