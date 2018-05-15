library(fitzRoy)
library(lubridate)
fitzRoy::match_results

xx=fitzRoy::match_results
xx$year<-year(xx$Date)

xx$year<-year(xx$Date)
table(xx$year)
yy<-fitzRoy::player_stats
yy<-select( yy,Date, Season, Round, Venue, Team, Opposition)
yy<-distinct(yy)
table(yy$Season)
yytable<-yy$Season
yy2<-table(yy$Season)
yy2<-as.data.frame(yy2)
yy2$Freq/2
yy2$uniquegames<-yy2$Freq/2
yy2
table(xx$year)

player2016<-fitzRoy::player_stats%>%
              select(Season, Round, Match_id)%>%
              distinct%>%filter(Season==2016)%>%
              group_by(Round)%>%
              summarise(n = n())

check2016<-xx%>%select(year, Round)%>%
            filter(year==2016)%>%
            group_by(Round)%>%summarise(n = n())

###missing game round 14 round 14 2016 - Brisbane Vs Richmond
####https://www.footywire.com/afl/footy/ft_match_statistics?mid=6288


player2017<-fitzRoy::player_stats%>%
  select(Season, Round, Match_id)%>%
  distinct%>%filter(Season==2017)%>%
  group_by(Round)%>%
  summarise(n = n())

check2017<-xx%>%select(year, Round)%>%
  filter(year==2017)%>%
  group_by(Round)%>%summarise(n = n())
View(player2017)
View(check2017)

###Round 17,
fitzRoy::player_stats%>%
  +     select(Season, Round, Match_id, Team, Opposition)%>%
  +     distinct%>%filter(Season==2017, Round=="Round 17")

###have 9442, 9443, 9444

####missing
##   https://www.footywire.com/afl/footy/ft_match_statistics?mid=9445

##  https://www.footywire.com/afl/footy/ft_match_statistics?mid=9447

##  https://www.footywire.com/afl/footy/ft_match_statistics?mid=9446

##  https://www.footywire.com/afl/footy/ft_match_statistics?mid=9448

##  https://www.footywire.com/afl/footy/ft_match_statistics?mid=9450

##  https://www.footywire.com/afl/footy/ft_match_statistics?mid=9449

###Round 18

##missing
##    https://www.footywire.com/afl/footy/ft_match_statistics?mid=9451



Round 18



