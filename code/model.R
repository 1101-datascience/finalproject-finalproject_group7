
data <- read.csv("./data/Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")


data <- na.omit(data)
cnt = 0
for (row_idx in 1:nrow(data)){
  cnt <- cnt + 1
  # if (data[row_idx,]$timestamp == "11/3/2020 19:56:58"){
  #   print(row_idx)
  #   break
  # }
  for (feat in c('company')){
    # print(feat_idx)
    print(feat)
    print(data[row_idx,feat])

    data[row_idx,feat] <- gsub("\U00A0", "", data[row_idx,feat])
    
    break

  }
  print(data[row_idx,])
  
  break

}

data[34554,]
## 75% of the sample size
smp_size <- floor(0.9 * nrow(data))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train <- data[train_ind, ]
test <- data[-train_ind, ]
test <- subset(test,select=-c(basesalary))

s_data <- data.frame(
  Company = data$company,
  title = data$title,
  location = data$location,
  yearofexperience = data$yearsofexperience,
  yearsatcompany = data$yearsatcompany,
  basesalary = data$basesalary
  
)

#define one-hot encoding function
dummy <- dummyVars(~ ., data=s_data)

#perform one-hot encoding on data frame
final_df <- data.frame(predict(dummy, newdata=s_data))


## 75% of the sample size
smp_size <- floor(0.75 * nrow(final_df))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(final_df)), size = smp_size)

train <- final_df[train_ind, ]
test <- final_df[-train_ind, ]
test <- subset(test,select=-c(basesalary))



bstSparse <- xgboost(data = train, max.depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic")


#model = svm(formula = basesalary ~ ., data = train)

# model <- lm(basesalary ~ .,  data = train)
predict(model,test)

