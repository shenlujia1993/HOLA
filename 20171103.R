setwd("D:/data/")

library(rJava)
library(Rwordseg)
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)
library(xlsxjars)
library(xlsx)


installDict("D://data//dic_lib//西班牙足球联赛所有球队.scel", "spain_teams")
installDict("D://data//dic_lib//英格兰足球联赛所有球队.scel", "premier_teams")
installDict("D://data//dic_lib//意大利足球联赛所有球队.scel", "italian_teams")
installDict("D://data//dic_lib//篮球词汇大全.scel", "basketball_all")
installDict("D://data//dic_lib//世界足球联赛所有球队.scel", "football_teams")
installDict("D://data//dic_lib//篮球明星.scel", "basketball_stars")
installDict("D://data//dic_lib//足球明星.scel", "football_stars")
installDict("D://data//dic_lib//足球词汇大全.scel", "football_all")
installDict("D://data//dic_lib//NBA词库【官方推荐】.scel", "NBA_official")
installDict("D://data//dic_lib//F1赛车【官方推荐】.scel", "f1_official")
installDict("D://data//dic_lib//足球【官方推荐】.scel", "football_official")
installDict("D://data//dic_lib//篮球【官方推荐】.scel", "basketball_official")
installDict("D://data//dic_lib//欧冠在这里【官方推荐】.scel", "champions_league")
installDict("D://data//dic_lib//广州恒大俱乐部.scel", "hengda")
installDict("D://data//dic_lib//巴塞罗那.scel", "barca")
installDict("D://data//dic_lib//2009中超球员全名单.scel", "chinese_league")


news <- read.csv("D://data//news_title.csv", encoding="UTF-16")
zscore <- data.frame(scale(news$read), scale(news$comment))

k <- kmeans(zscore, 3)
news$cluster <- k$cluster


# cluster1: low reading, low comment
cluster1 <- subset(news, news$cluster==1)

# cluster2: hight reading, average comment
cluster2 <- subset(news, news$cluster==2)

# cluster3: average reading, high comment
cluster3 <- subset(news, news$cluster==3)


for(i in 1:3){
  cluster_name <- paste("cluster",i, sep = "")
  cluster_name <- subset(news, news$cluster==i)
  
  txt_name <- paste("txt", i, sep = "")
  txt_name <- as.character(unlist(cluster_name[,1]))
  
  txt_name <- enc2utf8(txt_name)
  txt_name <- txt_name[Encoding(txt_name)!='unknown']
  txt_name <- txt_name[txt_name!=" "]
  txt_name <- gsub(pattern = "[0-9]", "", txt_name)
  
  segmented <- paste("v", i, sep = "")
  segmented <- unlist(segmentCN(txt_name))
  
  table_name <- paste('t', i, sep = "")
  table_name <- table(unlist(segmented))
  table_name <- rev(sort(table_name))
  
  word_name <- paste("word", i, sep = "")
  word_name <- data.frame(word=names(table_name), freq=table_name)
  word_name <- subset(word_name, nchar(as.character(word_name))>1)
  
  result <- list()
  result[[i]] <- word_name

  
  write.csv(result,file="result.csv",row.names=FALSE)
  
  print(head(result))
}

