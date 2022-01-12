library(ggplot2)
library(gapminder)

data <- read.csv("Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")

data <- na.omit(data)


Education_plot <- ggplot(data, aes(x = basesalary, y = Education)) +
  geom_point()
Education_plot

Race_plot <- ggplot(data, aes(x = basesalary, y = Race)) +
  geom_point()
Race_plot
