incarceration_df <- read.csv("incarceration_trends.csv")

library(plotly)

incarceration_df <- select(incarceration_df, total_jail_pop, white_jail_pop, aapi_jail_pop)

fig <- plot_ly(data = incarceration_df, x= ~total_jail_pop, y = ~100 * white_jail_pop / total_jail_pop, name = 'Percent White Islander Prisoners', type = 'scatter', mode = 'markers', marker=list(color='rgb(255,0,0)')) %>%
    add_trace(y = ~100 * aapi_jail_pop / total_jail_pop, name = 'Percent Asian/Pacific Islanders Prisoners', mode = 'markers', marker=list(color='rgb(0,0,255)')) %>%
    layout(title = 'Percentage of Prisoners who are White or Asians/Pacific Islanders Compared to Total Number of Prisoners', xaxis = list(title = 'Total Number of Prisoners'), plot_bgcolor = "#e5ecf6",
           yaxis = list(title = 'Percent of Prisoners', range = c(0,100)), legend = list(title=list(text='Race of Prisoners')))