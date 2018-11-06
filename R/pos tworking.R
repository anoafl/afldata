
library(fitzRoy)
library(tidyverse)

df<-fitzRoy::player_stats

df1<-fitzRoy::get_footywire_stats(9514:9594)

df<-df%>%filter(Season != 2018)
df<-df%>%
  filter(Season != 2018) #filters out the 2018 data (incomeplete that was downloaded when installing fitzRoy for first time)
df2<-rbind(df, df1) #stacks the datasets on top of each other

df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  group_by(Season, Opposition) %>%
  summarise(average_hb2k=mean(hb2k)) %>%
  filter(Season==2018)

#what this table gives us is for each team,
#when they are the opposition what was their opponents kick to handball ratio vs them

#we can check this by plotting and labelling our data

df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition=="Collingwood")%>%
  ggplot(aes(x=Date, y=hb2k)) +geom_point() +
  geom_text(aes(label=Team), size=2)

# so can check the collingwood page
# https://www.footywire.com/afl/footy/tg-collingwood-magpies

# can see that we have the teams that played collingwood in the right order
#now need to check if that hawthorn label, was the handball 2 kick ratio
#for hawthorn vs collingwood.
df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition=="Collingwood")%>%
  ggplot(aes(x=Date, y=hb2k)) +geom_point() +
  geom_text(aes(label=Team), size=2) +
  geom_text(aes(label=hb2k), vjust=-1, size=3)

#check if hawthorns handbal to kick ratio vs collingwood in round 1 was
# 0.7866
#https://www.footywire.com/afl/footy/ft_match_statistics?mid=9519

#then what I need is the competition average handball to kick ratio
#plot this as a straight line y= whatever the average is


df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  group_by(Season)%>%
  summarise(meanhb2k=mean(hb2k))

#here we can see the average handballs to kicks for 2018 is 0.757

df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition=="Collingwood")%>%
  ggplot(aes(x=Date, y=hb2k)) +geom_point() +
  geom_text(aes(label=Team), size=2) +
  geom_hline(yintercept = 0.757) +ggtitle("Opponents handball 2 kick ratio vs Collingwood")

########################################

#then we might want to see how collingwoods opponent stacks
#up round by round vs the other teams
df3<-df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition == "Collingwood")



df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition != "Collingwood") %>%
  ggplot(aes(x=Round, y=hb2k))+geom_point(data=df3)+
  geom_point(aes(colour="red"))

### Check data

df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition != "Collingwood") %>%
  ggplot(aes(x=Round, y=hb2k))+geom_point(data=df3)+
  geom_point(colour="grey") +geom_text(data=df3, aes(label=hb2k))


#####
df4<-df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  mutate(hb2k=thb/tk) %>%
  filter(Season==2018)
d_bg <- df4[, -4]

ggplot(df4, aes(x = thb, y = tk, colour=Opposition)) +
  geom_point(data = d_bg, colour = "grey", alpha = .5) +
  geom_point() +geom_text(aes(label=Team),size=0.5)+
  facet_wrap(~ Opposition)+
  guides(colour = FALSE) +
  theme_bw()


##########
df3<-df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  # mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition == "Collingwood")



df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  # mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
  filter(Opposition != "Collingwood") %>%
  ggplot(aes(x=Opposition, y=thb))+geom_point(data=df3)+
  geom_point(aes(colour="red"))


  df2%>%
  select(Season, Round, K,HB, Team, Opposition, Date ) %>%
  group_by(Season, Round, Team, Opposition, Date)%>%
  summarise(tk=sum(K), thb=sum(HB)) %>%
  # mutate(hb2k=thb/tk) %>%
  filter(Season==2018)%>%
    ggplot(aes(x = fct_reorder(Opposition, thb, fun = median,.desc =TRUE), y=thb))+geom_boxplot()



  # Step 7 - Lets see some background data

  # ```{r}

  df4<-df2%>%
    select(Season, Round, K,HB, Team, Opposition, Date ) %>%
    group_by(Season, Round, Team, Opposition, Date)%>%
    summarise(tk=sum(K), thb=sum(HB)) %>%
    mutate(hb2k=thb/tk) %>%
    filter(Season==2018)
  d_bg <- df4[, -4]

  ggplot(df4, aes(x = thb, y = tk, colour=Opposition)) +
    geom_point(data = d_bg, colour = "grey", alpha = .5) +
    geom_point() +
    facet_wrap(~ Opposition)+
    guides(colour = FALSE) +
    theme_bw()
#


