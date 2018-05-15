###########getting weather data in##########
library(lubridate)
setwd("C:/Users/Rober/Google Drive/AFL brownlow/afl attack defence/")
df<-fitzRoy::match_results

BOMVenueLookup<-read.csv(file="BOM Mapping.csv",stringsAsFactors=FALSE)
colnames(BOMVenueLookup)<-c("Venue","Description","StationNo")

StationsList<-unique(BOMVenueLookup$StationNo)

#Load in BOM daily observations
testingbom1<-read.csv(file="testingbom.csv",stringsAsFactors=FALSE)
testingbom2<-read.csv(file="testingbomm.csv",stringsAsFactors=FALSE) #wheretestingbom3 is updated weather data
testingbom<-rbind(testingbom1,testingbom2)
# View(testingbom)
colnames(testingbom)[1]<-"StationNo"
colnames(testingbom)[5]<-"Rainfall"
#str(testingbom)

#Convert Y,M,D to date
testingbom$date<-ISOdate(testingbom$Year,testingbom$Month,testingbom$Day,0,0,0)

testingbom$date<-ymd(testingbom$date)

# Merge the AFL data set with the BOM rainfall ----------------------------

AFLDataWithBOMStation<-merge(x=df,y=BOMVenueLookup,by = "Venue",all.x=TRUE)
AFLDataWithBOMStation$Date<-ymd(AFLDataWithBOMStation$Date)


colnames(AFLDataWithBOMStation)[3] <- 'date'
#No missing observations (i.e. lookup table is solid)
# names(AFLDataWithBOMStation)

AFLDataWithRainfall<-merge(x=AFLDataWithBOMStation,y=testingbom[,c("StationNo","date","Rainfall")],by=c("StationNo","date"),all.x=TRUE,all.y=FALSE)

AFLDataWithRainfall<-AFLDataWithRainfall[order(AFLDataWithRainfall$date),]
