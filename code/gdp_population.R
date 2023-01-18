# Analyze life expectancy and CO2 emissions versus population
# January 17 2023

2+2
2+2
library(tidyverse)
spec(gapminder_1997)
library(readr)
gapminder_1997 <- read_csv("gapminder_1997.csv")
name <- Ben
name
age <- 26
name <- "Ben"
name
name <- "Harry Potter"
name
age
read_csv()
?read_csv()
read_csv("gapminder_1997.csv")
read_csv(file = "gapminder_1997.csv")
getwd()
round(3.1415)
round(3.1415,3)
name <- Ben
name <- "Ben"
name
round(x = 3.1415)
round(x = 3.1415, digits = 2)
round(digits = 2, x = 3.1415)
round(2, 3.1415)
round(3.1415, 2)

# plotting the data

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy")+
  geom_point(shape = 15) +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "PuBuGn") +
  aes(size = pop/1000000) +
  labs(size = "Population (in millions)")

# short handed ggplot
ggplot(data = gapminder_1997,
       aes (x = gdpPercap, y = lifeExp, color = continent, shape = continent, size = pop)) +
  geom_point(shape = 17)

# read in all of the data from gapminder (more years than 1997)


gapminder_data <- read_csv("gapminder_data.csv") 

View(gapminder_data)
View(gapminder_1997)

dim(gapminder_data)
head(gapminder_data)
tail(gapminder_data)

ggplot(data = gapminder_1997) +
  aes(x= continent, y=lifeExp, color = continent) +
  geom_violin() +
  geom_jitter(aes(size = pop))


# learn about data
str(gapminder_data)

# histogram

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 10) +
  theme_classic()

install.packages("ggprism")
library("ggprism")

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 10) +
  theme_prism()

ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_grid(rows = vars(continent))

ggsave("figures/awesome_plot.jpg", width = 6, height = 4)
?ggsave


