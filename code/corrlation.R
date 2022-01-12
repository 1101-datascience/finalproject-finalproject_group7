library(corrplot)

#read data
data <- read.csv("./data/Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")

#select feature
select_feat =  c("company", "title", "tag", "basesalary", "gender", "Race", "Education", "yearsofexperience", "yearsatcompany", "cityid")
drop_feat = setdiff(colnames(train),select_feat)

train <- subset(train, select = select_feat)
test <- subset(test, select = select_feat)

#drop na
train <- na.omit(train)
test <- na.omit(test)

print(any(is.na(train)))
print(any(is.na(test)))

#label encoding
for (i in c("company", "title", "tag", "gender", "Race", "Education" )){  
  # print(train[, i])
  train[, i] <- as.numeric(factor(train[, i]))
  test[, i] <- as.numeric(factor(test[, i]))  
}

#corrlation
#method = square/number/shade
corrplot(cor(train),
         method = "shade",
         type = "full"
)