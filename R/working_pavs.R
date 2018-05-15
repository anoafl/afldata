####recreating PAV#####

afltables<-fitzRoy::afldata

#####step 1 get team names matching to join on scores to player data
afltables<- mutate_if(tibble::as_tibble(afltables),
                      is.character,
                      str_replace_all, pattern = "Greater Western Sydney", replacement = "GWS")
afltables <- mutate_if(tibble::as_tibble(afltables),
                       is.character,
                       str_replace_all, pattern = "Brisbane Lions", replacement = "Brisbane")
# names(afltables)


afltables<-filter(afltables, Season>2010)
afltables<-filter(afltables, Season<2017)

afltables_home<-filter(afltables, Playing.for==Home.team)
afltables_away<-filter(afltables,Playing.for==Away.team)

names(afltables_home)

afltables_home$pavO<-afltables_home$Home.score +
                      0.25*afltables_home$Hit.Outs +
                      3*afltables_home$Goal.Assists+
                      afltables_home$Inside.50s+
                    afltables_home$Marks.Inside.50+
                  (afltables_home$Frees.For-afltables_home$Frees.Against)

afltables_home$pavD<-20*afltables_home$Rebounds +
                    12*afltables_home$One.Percenters+
                  (afltables_home$Marks-4*afltables_home$Marks.Inside.50+2*(afltables_home$Frees.For-afltables_home$Frees.Against))-
                  2/3*afltables_home$Hit.Outs

afltables_home$pavM<-15*afltables_home$Inside.50s+
                      20*afltables_home$Clearances +
                      3*afltables_home$Tackles+
                      1.5*afltables_home$Hit.Outs +
                      (afltables_home$Frees.For-afltables_home$Frees.Against)



afltables_away$pavO<-afltables_away$Away.score +
  0.25*afltables_away$Hit.Outs +
  3*afltables_away$Goal.Assists+
  afltables_away$Inside.50s+
  afltables_away$Marks.Inside.50+
  (afltables_away$Frees.For-afltables_away$Frees.Against)


afltables_away$pavD<-20*afltables_away$Rebounds +
  12*afltables_away$One.Percenters+
  (afltables_away$Marks-4*afltables_away$Marks.Inside.50+2*(afltables_away$Frees.For-afltables_away$Frees.Against))-
  2/3*afltables_away$Hit.Outs



afltables_away$pavM<-15*afltables_away$Inside.50s+
  20*afltables_away$Clearances +
  3*afltables_away$Tackles+
  1.5*afltables_away$Hit.Outs +
  (afltables_away$Frees.For-afltables_away$Frees.Against)

fulltable<-rbind(afltables_home,afltables_away)
names(fulltable)

fulltable2016<-filter(fulltable, Season==2016)
table(fulltable2016$Season)

### check get same value for bryce gibbs  ###matches blog post http://www.hpnfooty.com/?p=21810

fulltable2016%>%group_by(First.name, Surname)%>% summarise(total_mid_pav=sum(pavM))%>%
filter(Surname=="Gibbs", First.name=="Bryce")
fulltable2016%>%group_by(Playing.for)%>% summarise(team_mid_pav=sum(pavM))
100*(3984/37702)


