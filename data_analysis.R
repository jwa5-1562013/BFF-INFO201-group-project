library("dplyr")
library("data.table")

all <- fread(file = "data/all.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads_2010_2012 <- fread(file = "data/recent_grads_2010_2012.csv", stringsAsFactors = FALSE, header = TRUE)
male <- fread(file = "data/male.csv", stringsAsFactors = FALSE, header = TRUE)
female <- fread(file = "data/female.csv", stringsAsFactors = FALSE, header = TRUE)
grad_degree <- fread(file = "data/grad_degree.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads <- fread(file = "data/recent_grads.csv", stringsAsFactors = FALSE, header = TRUE)
overall <- fread(file = "data/overall.csv", stringsAsFactors = FALSE, header = TRUE)


# 2012 vs 2016 Analysis
# Compares the median earnings for bachelor students under the age of 28 in 2012 vs 2016
recent_grads_comparison <- merge(recent_grads_2010_2012, recent_grads, by = c("Major", "Major_Category"), suffixes = c("_2012", "_2016")) %>% 
                           mutate(Median_difference = median_earnings_2016 - median_earnings_2012) %>% 
                           select(Major, Major_Category, median_earnings_2012, median_earnings_2016, Median_difference)

# Earnings Growth over Time after Graduation Analysis
# Compares the median earnings for recent bachelor graduates (under the age of 28) vs people of all ages with only the bachelor's degree
earning_growth_comparison <- merge(recent_grads, all, by = c("Major", "Major_Category"), suffixes = c("_young", "_all")) %>% 
                             mutate(Median_difference = median_earnings_all - median_earnings_young) %>% 
                             select(Major, Major_Category, Median_difference)

# Grad School Premium Analysis
# Analyze the extent to which going to graduate school increases earnings for each major
grad_comparison <- merge(recent_grads, grad_degree, by = c("Major", "Major_Category"), suffixes = c("_bachelor", "_graduate")) %>% 
                   mutate(Median_difference_gc = median_earnings_graduate - median_earnings_bachelor) %>% 
                   select(Major, Major_Category, Median_difference_gc)

# Relationship between Median Earnings and Women's Share of Students in Each Major
# Analyzes whether there is a relationship between the two factors
earnings_female <- merge(overall, female, by = c("Major", "Major_Category"), suffixes = c("_overall", "_female")) %>% 
                   mutate(female_share = total_majors_female / total_majors_overall) %>%                  
                   select(Major, Major_Category, median_earnings_overall, female_share)

#
combined <- merge(recent_grads_comparison, earning_growth_comparison, by = c("Major", "Major_Category"), suffixes = c("_rgc", "_egc")) %>% 
            merge(grad_comparison, by = c("Major", "Major_Category"), suffixes = c("", "_gc")) %>% 
            merge(earnings_female, by = c("Major", "Major_Category"), suffixes = c("", "_ef"))

write.csv(combined, "data/combined.csv", row.names = FALSE)





