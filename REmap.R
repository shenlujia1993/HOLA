setwd("D:/data/")

library(devtools)
install_github('lchiffon/REmap')
install_github('badbye/baidumap')
library(REmap)
library(baidumap)
library(ggplot2)
library(ggmap)
library(rjson)
library(bitops)
library(RCurl)


ak <- 'k52UnXmPW2XgIXMIEfRN9FWPwpcLCrn1'
options(baidumap.key = ak)

baidu_lat <- c()
baidu_lng <- c()
baidu_address <- c()
baidu_geo <- c()

test_city <- c("内蒙古", "北京大学", "遵义", "茂名", "益阳")

for(location in test_city){
  
  url <- paste("http://api.map.baidu.com/geocoder/v2/?ak=",ak,"&output=json&address=",location, sep = "")
  url_string <- URLencode(url)
  
  connect <- url(url_string)
  
  temp_geo <- fromJSON(paste(readLines(connect, warn = F), collapse = ""))
  temp_lat <- temp_geo$result$location$lat
  temp_lng <- temp_geo$result$location$lng
  
  close(connect)
  
  baidu_geo <- c(baidu_geo, temp_geo)
  baidu_lat <- c(baidu_lat, temp_lat)
  baidu_lng <- c(baidu_lng, temp_lng)
  baidu_address <- c(baidu_address, location)
  
}

content <- data.frame(baidu_address, baidu_lat, baidu_lng, stringsAsFactors = F)
