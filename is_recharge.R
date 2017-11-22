# predict if a user is going to recharge
# using logistic

setwd("D:/data/") # set working space

users<-read.csv("D://data//data set///data//happyfish_user_info.csv",header = T) # getting data, until 2017/8/29
colnames(users) <- c("uid", "register_time", "active_time", "followed", "topic", "comment", "is_host", "is_recharge")
# revert date to date
users$register_time <- as.Date(users$register_time)
users$active_time <- as.Date(users$active_time)

#load_time <- as.Date('2017-8-28')
users$active_to_reg <- users$active_time-users$register_time
users$active_to_reg <- as.numeric(users$active_to_reg)

# using logit linear models
recharge_or_not <- glm(is_recharge~followed+topic+comment+is_host+active_to_reg, data = users, family = binomial())
# output the 
summary(recharge_or_not)
exp(coef(recharge_or_not)) 

# predic active length
followed <- c(mean(users$followed))
comment <- c(mean(users$comment))
active_to_reg <- rep(c(4, 28, 84, 218), nrow(users))
testdata_1 <- data.frame(followed, comment, active_to_reg)
testdata_1$prob <- predict(recharge_or_not, newdata = testdata_1, type = "response")

# predict comment
followed <- c(mean(users$followed))
active_to_reg <- 50.67
comment <- rep(c(1:10), nrow(users))
testdata_2 <- data.frame(followed, comment, active_to_reg)
testdata_2$prob <- predict(recharge_or_not, newdata = testdata_2, type = "response")

# predict followed
active_to_reg <- 50.67
comment <- c(mean(users$comment))
followed <- rep(seq(0,100,5), nrow(users))
testdata_3 <- data.frame(followed, comment, active_to_reg)
testdata_3$prob <- predict(recharge_or_not, newdata = testdata_3, type = "response")

result_3 <- testdata_3[1:21,]
result_3$comment <- round(result_3$comment,2)
result_3$prob <- round(result_3$prob,4)
result_3$diff <- c("", round(as.numeric(diff(result_3$prob)),4))



#######################################################################################

# hosts data
hosts<-read.csv("D://data//is_host.csv",header = F)
colnames(hosts) <- c("uid", "register", "active", "followed", "topic", "comment", "recharge")
hosts$register <- as.Date(hosts$register)
hosts$active <- as.Date(hosts$active)
hosts$active_length <- as.numeric(hosts$active - hosts$register)


