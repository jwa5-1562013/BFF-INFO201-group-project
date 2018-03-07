library("dplyr")
library("data.table")

all <- fread(file = "data/all.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads_2010_2012 <- fread(file = "data/recent_grads_2010_2012.csv", stringsAsFactors = FALSE, header = TRUE)
male <- fread(file = "data/male.csv", stringsAsFactors = FALSE, header = TRUE)
female <- fread(file = "data/female.csv", stringsAsFactors = FALSE, header = TRUE)
grad_degree <- fread(file = "data/grad_degree.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads <- fread(file = "data/recent_grads.csv", stringsAsFactors = FALSE, header = TRUE)
overall <- fread(file = "data/overall.csv", stringsAsFactors = FALSE, header = TRUE)

# Select the 4 columns to be shown ("Major", "Major Category", "Median", "Unemployment Rate")
# and fix the names by adding the given suffix
selectFix <- function(df, suffix) {
  fixed <- select(df, "Major", "Major_Category", "median_earnings", "unemployment_rate")
  colnames(fixed)[c(3,4)] <- c(paste0("Median_", suffix), paste0("Unemployment_rate_", suffix))
  return(fixed)
}

# 2012 vs 2016 Analysis
recent_grads_comparison <- merge(selectFix(recent_grads_2010_2012, "2012"), selectFix(recent_grads, "2016"), 
                                 by = c("Major", "Major_Category")) %>% 
                           mutate(Median_difference = Median_2016 - Median_2012)

# recent grads vs all (only bachelor) Earning Growth over Time Analysis
earning_growth_comparison <- merge(selectFix(recent_grads, "young"), selectFix(all, "all"), 
                                   by = c("Major", "Major_Category")) %>% 
                             mutate(Median_difference = Median_all - Median_young)

# Grad school premium Analysis
grad_comparison <- merge(selectFix(recent_grads, "bachelor"), selectFix(grad_degree, "graduate"), 
                         by = c("Major", "Major_Category")) %>% 
                   mutate(Median_difference = Median_graduate - Median_bachelor)

# Male vs Female Analysis (Median Earnings vs. Women's share of majors)
earnings_female <- merge(overall, female, by = c("Major", "Major_Category"), suffixes = c("_overall", "_female")) %>% 
                   mutate(female_share = total_majors_female / total_majors_overall) %>%                  
                   select(Major, Major_Category, median_earnings_overall, female_share)
                   







