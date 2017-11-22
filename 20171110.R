setwd("D:/data/")


apps <- read.csv("D://data//app3.csv", header = T)
apps$apps <- as.character(apps$apps)

backet <- data.frame(matrix(NA, nrow(apps), 2))

backet[1,1]=apps[1,1]
backet[1,2]=apps[1,2]

app_list <- list()

for(i in 2:nrow(apps)){
  
  if(apps[i,1]==apps[i-1,1]){
    
    backet[i,2]=paste(backet[i-1,2], apps[i, 2], sep = " ")
    
  }
  
  else{
    
    backet[i,2]=apps[i,2]
    app_list[i]=apps[i-1,2]
    
  }

}
  
  
aa <- data.frame(apps)
aa$APP <- as.character(aa$APP)
bb <- as(split(aa[,"APP"], aa[,"id"]), "transactions")
c <- apriori(bb, parameter = list(support=0.1, confidence=0.8))
result <- as(c, "data.frame")
write.csv(result, "app_installed_result.csv")


  
  
  
