setwd("D:/data/")

library(mlbench)
data <- data("PimaIndiansDiabetes2")

library(VIM)
library(mice)

md.pattern(PimaIndiansDiabetes2) # ditect missing values
aggr(PimaIndiansDiabetes2, prop=F, numbers=T) # plot missing values


library(caret)
# create missing values
preproc <- preProcess(PimaIndiansDiabetes2[.-9], method = "bagImpute")
data <- predict(preproc, PimaIndiansDiabetes2[,-9])
data$diabetes <- PimaIndiansDiabetes2$diabetes

# get train and test data
index <- createDataPartition(data$diabetes, times = 1, p=0.6, list = F)
train <- data[index, ]
test <- data[-index, ]

library(e1071)
model  <- naiveBayes(diabetes~., data=train)
pred <- predict(model, test)

library(gmodels)
CrossTable(test$diabetes, pred, prop.r = T, prop.c = F, prop.t = F, prop.chisq = F)

library(pROC)
pre <- predict(model, test, type="raw")

modelroc <- roc(test$diabetes, pre[,2])
plot(modelroc, print.auc=T)
