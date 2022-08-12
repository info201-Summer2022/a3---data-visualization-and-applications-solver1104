incarceration_df <- read.csv("incarceration_trends.csv")


library(plotly)

library(dplyr)

library(maps)
library(mapproj)

source("helpers.R")

statecounty_df <- group_by(incarceration_df, state, county_name) %>%
    summarize(aapi_jail = sum(aapi_jail_pop, na.rm = TRUE), total_jail = sum(total_jail_pop, na.rm = TRUE), white_jail = sum(white_jail_pop, na.rm = TRUE)) %>%
    mutate(percent_aapi = 100 * aapi_jail/total_jail, percent_white = 100 * white_jail/total_jail)

fig1 <- percent_map(statecounty_df$percent_aapi, "darkgreen", "% Asian/Pacific Islander Prisoners", "Percent of Prisoners Who are Asians/Pacific Islanders Over All Years", 0, 40)

fig2 <- percent_map(statecounty_df$percent_white, "darkorange", "% White Prisoners", "Percent of Prisoners Who are White Over All Years", 0, 100)
