# library(readxl)
# data2upload <- ("A:/OneDrive/PhD statistics/mixed models/margin.csv")
# NBA_Games_Master
#
# NBA_Team_BoxScores_Extended
#
# data2upload <- NBA_Team_BoxScores_Extended
# # names(data2upload)
# library(devtools)
# NBA_Team_BoxScores_Extended=data2upload
# use_data(NBA_Team_BoxScores_Extended,overwrite = TRUE)
#
devtools::check()
# #
# # library(devtools)
# devtools::install_github("jimmyday12/fitzroy")
# #
# # # use_data(player_stats_basic,overwrite = TRUE)
# # scoreprogression_unparsed=fitzRoy::scoreprogression_unparsed
# # player_stats_basic=fitzRoy::player_stats_basic
#
#
