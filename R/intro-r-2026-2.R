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

