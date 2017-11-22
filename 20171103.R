setwd("D:/data/")

library(rJava)
library(Rwordseg)
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)
library(xlsxjars)
library(xlsx)


installDict("D://data//dic_lib//���������������������.scel", "spain_teams")
installDict("D://data//dic_lib//Ӣ�������������������.scel", "premier_teams")
installDict("D://data//dic_lib//��������������������.scel", "italian_teams")
installDict("D://data//dic_lib//����ʻ��ȫ.scel", "basketball_all")
installDict("D://data//dic_lib//�������������������.scel", "football_teams")
installDict("D://data//dic_lib//��������.scel", "basketball_stars")
installDict("D://data//dic_lib//��������.scel", "football_stars")
installDict("D://data//dic_lib//����ʻ��ȫ.scel", "football_all")
installDict("D://data//dic_lib//NBA�ʿ⡾�ٷ��Ƽ���.scel", "NBA_official")
installDict("D://data//dic_lib//F1�������ٷ��Ƽ���.scel", "f1_official")
installDict("D://data//dic_lib//���򡾹ٷ��Ƽ���.scel", "football_official")
installDict("D://data//dic_lib//���򡾹ٷ��Ƽ���.scel", "basketball_official")
installDict("D://data//dic_lib//ŷ��������ٷ��Ƽ���.scel", "champions_league")
installDict("D://data//dic_lib//���ݺ����ֲ�.scel", "hengda")
installDict("D://data//dic_lib//��������.scel", "barca")
installDict("D://data//dic_lib//2009�г���Աȫ����.scel", "chinese_league")


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
