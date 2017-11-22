setwd("D:/data/")

# read data
users<-read.csv("D://data//user_recharge_info.csv",header = F)
user_info <- users[,c(3:5)]
colnames(user_info)<-c("times","amount","last_time")
user_info$last_time<-as.Date(as.character(user_info$last_time))
load_time <- as.Date("2017-7-26")
user_info$recency <- load_time - user_info$last_time
user_info$recency <- as.numeric(user_info$recency)
userinfo2<-user_info[,-3]

# scale data as normal distribution
zscoredfile <- scale(userinfo2)

# divide all recharged users into 4 groups
result <- kmeans(zscoredfile,4)

# divide users based on recency, frequency and monetary
userRMF <- userinfo2
userRMF$rankRR <- cut(userRMF$recency,3,labels = F)
userRMF$rankRR <- 6-userRMF$rankRR
userRMF$rankFF <- cut(userRMF$times,3,labels = F)
userRMF$rankMM <- cut(userRMF$amount, 3, labels = F)

# calculate each user's value, 50% recency, 30% frequency, 20% monetary
userRMF$score <- 0.5*userRMF$rankRR+0.3*userRMF$rankFF+0.2*userRMF$rankMM
