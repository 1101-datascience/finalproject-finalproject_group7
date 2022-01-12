library(corrplot)

#read data
data <- read.csv("./data/Levels_Fyi_Salary_Data.csv", encoding = "UTF-8")

#select feature
select_feat =  c("company", "title", "tag", "basesalary", "gender", "Race", "Education", "yearsofexperience", "yearsatcompany", "cityid", "dmaid")
drop_feat = setdiff(colnames(data),select_feat)

data <- subset(data, select = select_feat)

#drop na
data <- na.omit(data)

print(any(is.na(data)))

#label encoding
for (i in c("company", "title", "tag", "gender", "Race", "Education" )){  
  # print(train[, i])
  data[, i] <- as.numeric(factor(data[, i]))
}

#corrlation
#method = square/number/shade
corrplot(cor(data),
         method = "shade",
         type = "full"
)
