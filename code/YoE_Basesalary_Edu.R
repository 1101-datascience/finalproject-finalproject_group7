library(ggplot2)

data <- read.csv("Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")

data <- na.omit(data)

scatter_plot <- ggplot(data, aes(x = basesalary, y = yearsofexperience, color = as.factor(Education))) +
  geom_point()

scatter_plot
