library(Metrics)

# read parameters
# trailingOnly = TRUE means the first parameter start with 
# the actual parameter, which pass into R file
args = commandArgs(trailingOnly=TRUE)

# parse parameters
if (length(args)==0){
  stop("USAGE: Rscript randomForest.R with no arguments", call.=FALSE)
}

i <- 1
while(i < length(args)){
  if(args[i] == "--test")
    test_input <- args[i + 1]
  else if(args[i] == "--predict")
    predict_output <- args[i + 1]
  i <- i + 1
}

# read train_input & test_input
train_data <- read.csv(file = "ds_final/train_salary.csv", header = T, stringsAsFactors = F)
test_data <- read.csv(file = "ds_final/test_salary.csv", header = T, stringsAsFactors = F)

train_data <- read.csv(file = train_input, header = T, stringsAsFactors = F)
test_data <- read.csv(file = test_input, header = T, stringsAsFactors = F)

final_ID <- 1 : nrow(test_data)
median_salary <- rep(median(train_data$basesalary), times = nrow(test_data))

result_final <- data.frame(ID = final_ID,
                           Base_salary = test_data$basesalary,
                           predictions = median_salary)


write.table(result_final, file = predict_output, row.names = F, quote = F, sep = ',')

# write.table(result_final, file = "null_model.csv", row.names = F, quote = F, sep = ',')
# ======================== print Final Test RMSE ========================

# [1] "Null Model Test RMSE:  56432.1"
print(
  paste('Null Model Test RMSE: ', round(rmse(result_final$Base_salary,
                                               result_final$predictions)
                                          , 2) 
  )
)

