library(rpart)

#feature process function#
trans <- function(x){
    x[,1:ncol(x)] <- lapply(x,function(y){ifelse((y==''), NA, y)})
    x$company <- as.factor(x$company)
    x$level <- as.factor(x$level)
    x$title <- as.factor(x$title)
    x$location <- as.factor(x$location)
    x$tag <- as.factor(x$tag)
    x$gender <- as.factor(x$gender)
    x$dmaid <- as.factor(x$dmaid)
    x$cityid <- as.factor(x$cityid)
    x$Race <- as.factor(x$Race)
    x$Education <- as.factor(x$Education)
    return(x)
}

#parse parameters
args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
    stop('Missing parameters', call. = FALSE)
}

i <- 1
while (i < length(args)) {
    if (args[i] == '--fold') {
        fold <- as.numeric(args[i + 1])
        i <- i + 1
    } else if (args[i] == '--train') {
        train <- args[i + 1]
        i <- i + 1
    } else if (args[i] == '--test') {
        test <- args[i + 1]
        i <- i + 1
    } else if (args[i] == '--report') {
        report <- args[i + 1]
        i <- i + 1
    } else if (args[i] == '--predict') {
        predict <- args[i + 1]
        i <- i + 1
    } else{
        stop(paste('Unknown flag', args[i]), call. = FALSE)
    }
    i <- i + 1
}

#read files
train <- read.csv(file = train, header = T, stringsAsFactors = F)
test <- read.csv(file = test, header = T, stringsAsFactors = F)

#features processing
train <- trans(train)
train <- train[,-c(1,11,14:24)]
train <- train[!(train$basesalary==0),]

test <- trans(test)
test <- test[,-c(1,11,14:24)]
test <- test[!(test$basesalary==0),]

#convert factors' level
data.merge <- rbind(train, test)
for (f in 1:length(names(data.merge))) {
    levels(train[, f]) <- levels(data.merge[, f])
}

#k-fold splits
len <- dim(train)[[1]]
train$ID <- 1:len
train$splitset <- ''
for (l in c(fold:1)) {
    train$splitset <- ifelse((train$ID <= (len * l / fold)), paste0('splitset', l), train$splitset)
}
Folds <- paste0('splitset', c(1:fold))
Folds[fold + 1] <- Folds[1]
results <- data.frame()


for (k in 1:fold) {
    #split the train set, use it to train a model and calculate the RMSE.
    train.set <- train[!(train$splitset %in% Folds[c(k, k + 1)]), ]
    train.set <- train.set[, -c(14,15)]
    model.train <- rpart(basesalary ~ .,
                         method = "anova",
                         cp = 7e-04,
                         data = train.set)
    train_RMSE <- data.frame(truth = train.set$basesalary,
                             pred = predict(model.train, train.set[,-8]))
    train_RMSE <- sqrt(sum((train_RMSE$truth-train_RMSE$pred)^2)/nrow(train_RMSE))
    
    #split the validation set, use it to train a model and calculate the RMSE.
    valid.set <- train[!(train$splitset %in% Folds[k]), ]
    valid.set <- valid.set[, -c(14,15)]
    model.valid <- rpart(basesalary ~ .,
                         method = "anova",
                         cp = 7e-04,
                         data = valid.set)
    valid_RMSE <- data.frame(truth = valid.set$basesalary,
                             pred = predict(model.valid, valid.set[,-8]))
    valid_RMSE <- sqrt(sum((valid_RMSE$truth-valid_RMSE$pred)^2)/nrow(valid_RMSE))
    
    #use the model trained from validation set to predict the test set,
    #then calculate the RMSE.
    test.set <- train[train$splitset %in% Folds[k], ]
    test.set <- test.set[, -c(14,15)]
    test_RMSE <- data.frame(truth = test.set$basesalary,
                             pred = predict(model.valid, test.set[,-8]))
    test_RMSE <- sqrt(sum((test_RMSE$truth-test_RMSE$pred)^2)/nrow(test_RMSE))
    
    #create a result frame
    RMSE.merge <- data.frame(set = paste0('fold', k),
                             training = round(train_RMSE, 2),
                             validation = round(valid_RMSE, 2),
                             test = round(test_RMSE, 2))
    
    results <- rbind(results, RMSE.merge)
}

#calculate the average of the result frame.
ave <- data.frame(set = 'ave.',
                  training = round(mean(results$training), 2),
                  validation = round(mean(results$validation), 2),
                  test = round(mean(results$test), 2))
result <- rbind(results, ave)

#predict the test data.
result2 <- data.frame(truth = test$basesalary,
                      pred = predict(model.valid, test[,-8]))
result2_RMSE <- sqrt(sum((result2$truth-result2$pred)^2)/nrow(result2))

#write files
if (file.exists(dirname(report))) {
    write.table(result, file = report, sep = ',',
                row.names = F, quote = F)
} else{
    dir.create(dirname(report))
    write.table(result, file = report, sep = ',',
                row.names = F, quote = F)
}

if (file.exists(dirname(predict))) {
    write.table(result2, file = predict, sep = ',',
                row.names = F, quote = F)
} else{
    dir.create(dirname(predict))
    write.table(result2, file = predict, sep = ',',
                row.names = F, quote = F)
}

#print the RMSE of the test data.
print(paste0('Fianl Test RMSE: ',round(result2_RMSE, 2)))
