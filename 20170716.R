setwd("D:/data/")

users<-read.csv("D://data//data set//20170823.csv",header = T, stringsAsFactors = F)

# transfer to data
users$register_time <- as.Date(users$register_time)
users$first_recharge_time <- as.Date(users$first_recharge_time)
users$last_recharge_time <- as.Date(users$last_recharge_time)
users$active_time <- as.Date(users$active_time)

# calculate active length, recahrge length and time from register to first recharge
users$active_length <- as.numeric(users$active_time-users$register_time)
users$recharge_length <- as.numeric(users$last_recharge_time - users$first_recharge_time)
users$register_to_recharge <- as.numeric(users$first_recharge_time - users$register_time)


# number of all users
user_no <- nrow(users)

# users who didn't active for a month
losing_users <- subset(users, users$active_time<"2017-7-23")
losing_users_no <- nrow(losing_users)

# users who didn't recharge for a month
losing_recharge <- subset(users, users$last_recharge_time<"2017-07-23")
losing_recharge_no <- nrow(losing_recharge)

# average time from register to recharge
avg_register_to_recharge <- mean(users$register_to_recharge)
avg_register_to_recharge2 <- mean(losing_users$register_to_recharge)
avg_register_to_recharge3 <- mean(losing_recharge$register_to_recharge)

# average length of recharge
avg_recharge_length <- mean(users$recharge_length)
avg_recharge_length2 <- mean(losing_users$recharge_length)
avg_recharge_length3 <- mean(losing_recharge$recharge_length)

# average recharge amount
avg_amount <- mean(users$amount)
avg_amount2 <- mean(losing_users$amount)
avg_amount3 <- mean(losing_recharge$amount)

# average recharge times
avg_frequency <- mean(users$frequency)
avg_frequency2 <- mean(losing_users$frequency)
avg_frequency3 <- mean(losing_recharge$frequency)

#divide users into groups by frequency
kmeans(users$frequency, 4)
kmeans(users$register_to_recharge, 4)
kmeans(users$amount, 5)

total_amount <- sum(users$amount)
total_recharge_times <-sum(users$frequency)

# rmf
users_rmf <- users[, c(3,4,11)]
rmf <- kmeans(users_rmf, 4)

