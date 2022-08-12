incarceration_df <- read.csv("incarceration_trends.csv")

library(plotly)

library(dplyr)

stateyear_df <- group_by(incarceration_df, state, year) %>%
    summarize(aapi_jail = sum(aapi_jail_pop, na.rm = TRUE), total_jail = sum(total_jail_pop, na.rm = TRUE), white_jail = sum(white_jail_pop, na.rm = TRUE)) %>%
    arrange(-aapi_jail/total_jail)

min_five <- unique(stateyear_df$state)[1:5]

incarceration_df_max_five <- filter(stateyear_df, state %in% min_five) %>%
    arrange(year)

fig <- plot_ly(incarceration_df_max_five, x = ~year, y = ~100 * aapi_jail/total_jail, color = ~state, name = ~paste(state, "Asian/Pacific Islander Prisoners")) %>%
    add_trace(y = ~100 * white_jail/total_jail, name = ~paste(state, "White Prisoners"), mode = "lines") %>%
    add_lines() %>%
    layout(title = 'Percentage of Prisoners who are White or Asians/Pacific Islanders Over Time', xaxis = list(title = 'Year'), plot_bgcolor = "#e5ecf6",
           yaxis = list(title = 'Percent of Prisoners'), legend = list(title=list(text='States')))

fig