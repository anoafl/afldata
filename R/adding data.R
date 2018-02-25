library(readxl)
data2upload <- read.csv("A:/OneDrive/PhD statistics/mixed models/margin.csv")
names(data2upload)
library(devtools)
margin=data2upload
use_data(margin,overwrite = TRUE)

devtools::check()

library(devtools)
# devtools::install_github("jimmyday12/FitzRoy")

use_data(player_stats_basic,overwrite = TRUE)
scoreprogression_unparsed=fitzRoy::scoreprogression_unparsed
player_stats_basic=fitzRoy::player_stats_basic


