incarceration_df <- read.csv("incarceration_trends.csv")

library(dplyr)

current_year_percents <- group_by(incarceration_df, fips) %>%
    filter(year == 2018) %>%
    summarize(county = county_name, state_name = state, aapi_jail = sum(aapi_jail_pop, na.rm = TRUE), total_jail = sum(total_jail_pop, na.rm = TRUE), white_jail = sum(white_jail_pop, na.rm = TRUE))

overall_aapi_percent <- 100 * sum(current_year_percents$aapi_jail, na.rm = TRUE) / sum(current_year_percents$total_jail, na.rm = TRUE)
max_aapi_percent <- max(100 * current_year_percents$aapi_jail / current_year_percents$total_jail, na.rm=TRUE)
max_aapi_county <- select(filter(current_year_percents, 100 * current_year_percents$aapi_jail / current_year_percents$total_jail == max_aapi_percent), county)
min_aapi_percent <- min(100 * current_year_percents$aapi_jail / current_year_percents$total_jail, na.rm=TRUE)
min_aapi_county <- select(filter(current_year_percents, 100 * current_year_percents$aapi_jail / current_year_percents$total_jail == min_aapi_percent), county)
num_min_counties <- nrow(min_aapi_county)

all_years_percents <- group_by(incarceration_df, fips) %>%
    summarize(county = county_name, state_name = state, aapi_jail = sum(aapi_jail_pop, na.rm = TRUE), total_jail = sum(total_jail_pop, na.rm = TRUE), white_jail = sum(white_jail_pop, na.rm = TRUE))

all_years_overall_aapi_percent <- 100 * sum(all_years_percents$aapi_jail, na.rm = TRUE) / sum(all_years_percents$total_jail, na.rm = TRUE)

all_counties_overall <- group_by(incarceration_df, year) %>%
    summarize(aapi_jail = sum(aapi_jail_pop, na.rm = TRUE), total_jail = sum(total_jail_pop, na.rm = TRUE), white_jail = sum(white_jail_pop, na.rm = TRUE))
highest_aapi_year_percent <- max(100 * all_counties_overall$aapi_jail / all_counties_overall$total_jail, na.rm=TRUE)
highest_aapi_year_num <- select(filter(all_counties_overall, 100 * all_counties_overall$aapi_jail / all_counties_overall$total_jail == highest_aapi_year_percent), year)