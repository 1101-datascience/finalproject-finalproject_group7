library(ggplot2)

data <- read.csv("Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")

data <- na.omit(data)

a <- unique(data$title)[1:7]
b <- unique(data$title)[8:15]

p1 <- ggplot(data[(data$title %in% a),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
    geom_boxplot() +
    xlab("title") +
    ylab("basesalary")
p2 <- ggplot(data[(data$title %in% b),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
    geom_boxplot() +
    xlab("title") +
    ylab("basesalary")

titleplot <- cowplot::plot_grid(p1, p2, labels = "AUTO", nrow = 2)
titleplot
