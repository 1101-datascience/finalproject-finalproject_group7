library("caret")
library("dplyr")

#train data
data <- read.csv("Fixed_train_data_no0.csv")

data <- data[, -c(4, 7)]

#Label Encoding 1,2,9,12,13
factors <- factor(data[, 1])
data[, 1] <- as.numeric(factors)
factors <- factor(data[, 2])
data[, 2] <- as.numeric(factors)
factors <- factor(data[, 9])
data[, 9] <- as.numeric(factors)
factors <- factor(data[, 12])
data[, 12] <- as.numeric(factors)
factors <- factor(data[, 13])
data[, 13] <- as.numeric(factors)
print(head(data))

#Target:base salary
data_X <- data[, -6]
data_Y <- data[, 6]

#test data
test_data <- read.csv("Fixed_test_data_no0.csv")

test_data <- test_data[, -c(4, 7)]

#Label Encoding 1,2,9,12,13
factors <- factor(test_data[, 1])
test_data[, 1] <- as.numeric(factors)
factors <- factor(test_data[, 2])
test_data[, 2] <- as.numeric(factors)
factors <- factor(test_data[, 9])
test_data[, 9] <- as.numeric(factors)
factors <- factor(test_data[, 12])
test_data[, 12] <- as.numeric(factors)
factors <- factor(test_data[, 13])
test_data[, 13] <- as.numeric(factors)
print(head(test_data))

#Target:base salary
test_X <- test_data[, -6]
test_Y <- test_data[, 6]

#Train model:rlm 80% train + 20% validation
train_ctrl <- trainControl(method = "cv", number = 5, savePredictions = TRUE)
set.seed(777)
fit_rlm_cv <- train(basesalary ~ ., data = data, method = 'rlm', metric = "RMSE",
                   trControl = train_ctrl)

#K-fold Predict RMSE
pred <- fit_rlm_cv$pred
pred$equal <- sqrt((pred$obs - pred$pred) ^ 2)

eachfold <- pred %>%                                        
  group_by(Resample) %>%                         
  summarise_at(vars(equal),                     
               list(RMSE = mean))              
print(eachfold)

#test
names(test_Y) <- "basesalary"

#predict base salary
pred_test <- data.frame(predict(fit_rlm_cv,test_X))
names(pred_test) <- "Pred_basesalary"

#RMSE
test_E <- data.frame((test_Y - pred_test))
names(test_E) <- "E"

RMSE <- sqrt(sum((test_Y - pred_test)^2) / nrow(pred_test))
print(paste0("RMSE:", round(RMSE, 2)))
#output
test_output <- data.frame(
  basesalary = test_Y,
  Pred_basesalary = pred_test, 
  E = test_E,
  stringsAsFactors = F
)

write.csv(test_output, file = "Output_use_Test_data.csv", row.names = FALSE)

#feature Importance
importance <- varImp(fit_rlm_cv, scale = FALSE)
print(importance)
plot(importance)

