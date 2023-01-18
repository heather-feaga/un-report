library(tidyverse)
getwd()
gapminder_data <- read_csv("data/gapminder_data.csv")

summarize(gapminder_data, averagelifeExp = mean(lifeExp), medianlifeExp=median(lifeExp))


#learning to pipe - first you put in what you are working on (gapminder_data) and then the piping notation so you don't have to keep typing the gapminder_data

gapminder_summary <-gapminder_data%>%
  summarize(averagelifeExp=mean(lifeExp))

gapminder_summary

#Filtering
gapminder_summary_2007<-gapminder_data%>%
  filter(year == 2007)%>%
  summarize(average = mean(lifeExp))

#finding average gdppercap for the first year in the dataset

#this one makes a data object
First_year_gdp_average <- gapminder_data%>%
  filter(year==1952)%>%
  summarize(average = mean(gdpPercap))

#this one shows the answer in the console
gapminder_data%>%
  filter(year==1952)%>%
  summarize(average = mean(gdpPercap))

#Using group_by()

#groups by year, will report average of each year
gapminder_data%>%
  group_by(year)%>%
  summarize(average = mean(lifeExp))

#groups by year, will report average of each year by country
gapminder_data%>%
  group_by(year, continent)%>%
  summarize(average = mean(lifeExp))

#groups by year, will report average of each year by country and the stdev
gapminder_data%>%
  group_by(year, continent)%>%
  summarize(average = mean(lifeExp), error = sd(lifeExp))

#using mutate function to calculate a new value in a column using other columns in the data

gapminder_data%>%
  mutate(gdp = pop * gdpPercap)

#mutate a new column which is population in millions
gapminder_data%>%
  mutate("population in millions" = pop / 1000000)

#select
gapminder_data%>%
  select(pop, year)

gapminder_data%>%
  select(-continent)

#pivot_wider
gapminder_data%>%
  select(country, continent, year, lifeExp)%>%
  pivot_wider(names_from = year, values_from = lifeExp)%>%
  View()

#working with messy data

read_csv("co2-un-data.csv")

#skip to the part of the data that is meaningful, the first row is a title so we want to skip that 
read_csv("co2-un-data.csv", skip = 1)

# the above was messy, but we know the data well enough we can assign our own names

read_csv("co2-un-data.csv",skip=2,
         col_names = c("region", "country", "year", "series", "value", "footnotes", "source"))

# Assign the data to an object called CO2_emmisions_dirty
CO2_emmisions_dirty <- read_csv("co2-un-data.csv",skip=2,
         col_names = c("region", "country", "year", "series", "value", "footnotes", "source"))

#type the name of the object to view it in the console
CO2_emmisions_dirty

# add a column with mutate

CO2_emmisions <-CO2_emmisions_dirty%>%
  select(country, year, series, value)%>%
  mutate(series = recode(series, 
                         "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions"))%>%
  pivot_wider(names_from = series, values_from = value)%>%
  filter(year == 2005)%>%
  select(-year)
# ^^names_from are coming from series, and the values_from takes the values from the values column

#join data by finding matching variables between the population data and emissions data. However, we don't have emissions data from 2005 but we have population data from 2005 and we don't have population from 2007 but we do have emissions data. So we are going to filter for only 2005. So take CO2 emissions dirty and add 2 new lines to filter so that we only have 2005

#filters are for rows, selects are for columns
CO2_emmisions_dirty%>%
  filter(year == 2005)%>%
#removes the year column
    select(-year)

#creating a new object called CO2_emmisions
#CO2_emmisions <- CO2_emmisions_dirty%>%
 # filter(year == 2005)%>%
#  select(-year)

#bringing in 2007 population data, filter only for rows 2007

gapminder_data_2007 <- read_csv("data/gapminder_data.csv")%>%
  filter(year == 2007)%>%
  select(country, pop, lifeExp, gdpPercap)

#innerjoin will only include countries that are shared in both of the tables

inner_join(CO2_emmisions, gapminder_data_2007, by = "country")

anti_join(CO2_emmisions, gapminder_data_2007, by = "country")

full_join(CO2_emmisions, gapminder_data_2007)

joined_CO2_pop <-inner_join(CO2_emmisions, gapminder_data_2007, by = "country")

#writing a CSV

write_csv(joined_CO2_pop, file = "data/joined_CO2_pop.csv")
