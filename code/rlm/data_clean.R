library("DMwR2")

#train data
data_All <- read.csv("Levels_Fyi_Salary_Data.csv")

#feature clean
clean_data <- data_All[, -c(1, 3, 14, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)]
print(dim(clean_data))

#k-NN
data <- knnImputation(clean_data)
print(head(data))

write.csv(data,file = "Fixed_data.csv", row.names = FALSE)