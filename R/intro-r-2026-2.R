# load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(summarytools)

#load raw data
raw_15min <- read.csv("data/raw/agg_15min_data.csv", stringsAsFactors = F)

#structure of data
str(raw_15min)


# Preliminary data exploration
head(raw_15min)
tail(raw_15min)
summary(raw_15min)
# another way
dfSummary(raw_15min)  #best summary - shows duplicates and missing values 

raw_15min[2,]
raw_15min[ ,2]
raw_15min[2,3]

mean(raw_15min$speed) #NA showed up because there is NA in the Speed column
hist(raw_15min$volume)


# learn about filters
occ_20plus <- raw_15min |> 
  filter(occupancy > 20)  

occ10_sp80 <- raw_15min |> 
  filter(occupancy < 10 & speed > 80)


# working with NA's

blank_example <- raw_15min |> 
  filter(is.na(speed))

complete_df <- raw_15min |> 
  filter(!is.na(speed))       # ! means is not

subset_o10s80 <- occ10_sp80 |> 
  filter(detector_id %in% c(101185, 101176))

saveRDS(complete_df, "data/clean_data.rds")
























