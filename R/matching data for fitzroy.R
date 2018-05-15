####getting unique playerIds

###step 1#########
    ###from afltables create list of full player names


devtools::install_github("jimmyday12/fitzroy")
library(fitzRoy)
library(tidyverse)
# fitzRoy::afldata
# View(fitzRoy::afldata)
# View(fitzRoy::player_stats)
###### step 1 rename teams to footywire format####

footywire_table=fitzRoy::player_stats
afltables<-fitzRoy::afldata
footywire_teams<-unique(footywire$Team)
afltables_teams<-unique(afltables$Playing.for)
footywire_teams<-sort(footywire_teams)
afltables_teams<-sort(afltables_teams)
View(footywire_teams)
View(afltables_teams)

####Step 2 #########
#changing the following
afltables_teams<-as.character(afltables_teams)
df <- mutate_if(tibble::as_tibble(afltables_teams),
                is.character,
                str_replace_all, pattern = "Brisbane Lions", replacement = "Brisbane")

df <- mutate_if(tibble::as_tibble(afltables_teams),
                is.character,
                str_replace_all, pattern = "Greater Western Sydney", replacement = "GWS")

##team names have changed correctly (Y)

####step 3 ############

footywire<-fitzRoy::player_stats
afltables<-fitzRoy::afldata
str(afltables$Playing.for)
afltables$Playing.for<-as.character(afltables$Playing.for)
afltables<- mutate_if(tibble::as_tibble(afltables),
                      is.character,
                      str_replace_all, pattern = "Greater Western Sydney", replacement = "GWS")
afltables <- mutate_if(tibble::as_tibble(afltables),
                is.character,
                str_replace_all, pattern = "Brisbane Lions", replacement = "Brisbane")
# unique(afltables$Home.team)

afltables$Name<-paste(afltables$First.name,afltables$Surname)

afltablesids<-select(afltables,Name, ID,Playing.for)
afltablesids_distinct=distinct(afltablesids)

footywire_names<-select(footywire,Player, Team )
footywire_names_distinct=distinct(footywire_names)

##create ids

afltablesids_distinct$joiner<-paste(afltablesids_distinct$Name,afltablesids_distinct$Playing.for)
# head(afltablesids_distinct)
footywire_names_distinct$joiner<-paste(footywire_names_distinct$Player,footywire_names_distinct$Team)
check<-full_join(footywire_names_distinct,afltablesids_distinct)

creating_ids_footywire<-left_join(footywire_names_distinct,afltablesids_distinct)

names_that_need_ids<-dplyr::filter(creating_ids_footywire,is.na(ID))
View(names_that_need_ids)
View(afltablesids_distinct)
getwd()
write.csv(names_that_need_ids, "names_need_ids.csv")
write.csv(afltablesids_distinct,"afltablesids.csv")

xx<-read.csv("names_need_ids.csv")
View(xx)
names(footywire)
footywire_players<-select(footywire, Player, Team)
footywire_players_distinct=distinct(footywire_players)
View(footywire_players_distinct)

write.csv(footywire_players_distinct, "adding_trades_2017.csv")
names(afltables)
afltables_players<-select(afltables,Playing.for, First.name, Surname, ID )
afltables_players_distinct=distinct(afltables_players)
afltables_players_distinct$Name<-paste(afltables_players_distinct$First.name, afltables_players_distinct$Surname)
head(afltables_players_distinct)
write.csv(afltables_players_distinct,"afltables_players_distinct.csv")
