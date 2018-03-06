library("dplyr")
library("data.table")

all_ages <- fread(file = "sum_all.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads_2010_2012 <- fread(file = "recent_grads_2010_2012.csv", stringsAsFactors = FALSE, header = TRUE)
male <- fread(file = "sum_male.csv", stringsAsFactors = FALSE, header = TRUE)
female <- fread(file = "sum_female.csv", stringsAsFactors = FALSE, header = TRUE)
grad <- fread(file = "sum_grad.csv", stringsAsFactors = FALSE, header = TRUE)
recent_grads <- fread(file = "recent_grads.csv", stringsAsFactors = FALSE, header = TRUE)


# 2012 vs 2016 data
recent_grads_2012_2016 <- select(recent_grads, "Major", "median_earnings", "unemployment_rate")
colnames(recent_grads_2012_2016)[c(2,3)] <- c("Median_2016", "Unemployment_rate_2016")

recent_grads_2010_2012 <- select(recent_grads_2010_2012, "Major", "Median", "Unemployment_rate") %>% 
                          mutate(Unemployment_rate = round(Unemployment_rate * 100, 1))
colnames(recent_grads_2010_2012)[c(2,3)] <- c("Median_2012", "Unemployment_rate_2012")

recent_grads_comparison <- merge(recent_grads_2010_2012, recent_grads_2012_2016, by = "Major") %>% 
                           mutate(Median_difference = Median_2016 - Median_2012, Unemployment_rate_difference = Unemployment_rate_2016 - Unemployment_rate_2012)

#grad school premium analysis
grad <- select(grad, "Major", "median_earnings", "unemployment_rate")
colnames(grad)[c(2,3)] <- c("Median_grad", "Unemployment_rate_grad")

colnames(recent_grads_2012_2016)[c(2,3)] <- c("Median_recent_grad", "Unemployment_rate_recent_grad")

grad_comparison <- merge(recent_grads_2012_2016, grad, by = "Major") %>% 
                   mutate(Median_difference = Median_grad - Median_recent_grad, Unemployment_rate_difference = Unemployment_rate_grad - Unemployment_rate_recent_grad)

# male vs female
male <- select(male, "Major", "median_earnings", "unemployment_rate")
colnames(male)[c(2,3)] <- c("Median_male", "Unemployment_rate_male")

female <- select(female, "Major", "median_earnings", "unemployment_rate")
colnames(female)[c(2,3)] <- c("Median_female", "Unemployment_rate_female")

gender_comparison <- merge(male, female, by = "Major") %>% 
                     mutate(Median_difference = Median_male - Median_female, Unemployment_rate_difference = Unemployment_rate_male - Unemployment_rate_female)

# recent grads




