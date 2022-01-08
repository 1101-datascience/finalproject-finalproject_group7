data <- read.csv("ds_final/Levels_Fyi_Salary_Data.csv")

## 75% of the sample size
smp_size <- floor(0.9 * nrow(data))
# remove cheat feature
data <- subset(data, select = -c(totalyearlycompensation, bonus, stockgrantvalue))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train <- data[train_ind, ]
test <- data[-train_ind, ]

# remove test$basesalary == 0
test <- subset(test, test$basesalary != 0)

# write table
write.table(train, file = "train_salary.csv", row.names = F, sep = ',')
write.table(test, file = "test_salary.csv", row.names = F, sep = ',')
