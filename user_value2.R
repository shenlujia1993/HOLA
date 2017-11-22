setwd("D:/data/")

# read data
users<-read.csv("D://data//user_recharge_info.csv",header = F)

users2 <- users[,c(2:5)]
colnames(users2)<-c("register_time","times","amount","last_time")
users2$last_time <- as.Date(as.character((users2$last_time)))
users2$register_time <- as.Date(as.character((users2$register_time)))
users2$recency <- load_time - users2$last_time
users2$recency <- as.numeric(users2$recency)
users2$register_to_now <- load_time - users2$register_time
users2$register_to_now <- as.numeric(users2$register_to_now)
users3 <- users2[,c(-1, -4)]
