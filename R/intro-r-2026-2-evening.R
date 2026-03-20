library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

clean_data <-read_rds("data/clean_data.rds")
detectors <- read_csv("data/raw/detectors.csv")

detectors_unique <- detectors |> 
  distinct(stationid, .keep_all = T)

