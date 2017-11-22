setwd("D:/data/")

library(rJava)
library(Rwordseg)
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)
library(xlsxjars)
library(xlsx)

# chat <- read.table("D://data//happyfish_chat_record.txt", fileEncoding="UTF-16")
# chat <- read.xlsx("D://data//happyfish_chat_record.xlsx", 1, encoding = "UTF-8")
news_title <- read.xlsx("D://data//news_title.xlsx", 1, encoding = "UTF-8")
news <- read.csv("D://data//news_title.csv", encoding="UTF-16")

news2 <-read.xlsx("D://data//news_read_2.xlsx", 1, encoding = "UTF-8")

installDict("D://data//dic_lib//钓鱼用语.scel", "fishing")


#c <- as.character(unlist(chat))
c <- as.character(unlist(topic))
c <- as.character(unlist(news2))

c <- as.character(unlist(cluster3$title))

tx <- enc2utf8(c)
txt <- tx[Encoding(tx)!='unknown']
txt <- txt[txt!=" "]
txt <- gsub(pattern = "[我|你|的|了|是|吧|他|总|谁|吗|就|好]", "", txt)
txt <- gsub(pattern = "[0-9]", "", txt)

d <- unlist(segmentCN(txt))
v <- table(unlist(d))
v <- rev(sort(v))
word <- data.frame(word=names(v), freq=v)
word <- subset(word,nchar(as.character(word))>1)

pword <- word[,c(1,3)]
wordcloud2(pword, color = 'random-dark', shape = 'circle')

write.csv(word,file="news2.csv",row.names=FALSE)

