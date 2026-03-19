---
title: "intro-r-2026-2-afternoon"
format: html
editor: visual
---
library(stringr)
  # Import
  csv_path <- "data/raw/presurvey_20260317.csv"
survey_raw <- rio::import(csv_path)

# Inspect
survey_raw |> glimpse()

# Clean + rename
survey <- survey_raw |> 
  clean_names() |> 
  rename(
    os = what_operating_system_are_you_using_for_this_workshop,
    prior_exp = which_of_the_following_are_true_regarding_your_experiences_with_r_prior_to_this_workshop,
    commute_time = what_is_the_approximate_travel_time_for_your_morning_commute_to_psu,
    distance = how_far_will_you_likely_travel
  )

glimpse(survey)


linux <- c("linux", "ubuntu", "debian", "fedora")
linux_paste <- paste(linux, collapse = "|")


survey2 <- survey |> 
  mutate(
    commute_digits = str_extract(commute_time, "[0-9]+"),
    distance_digits = str_extract(distance, "[0-9]+"),
    commute_min = as.numeric(commute_digits),
    distance_mi = as.numeric(distance_digits),
    travel_mph = if_else(
      !is.na(commute_min) & commute_min > 0,
      distance_mi / commute_min * 60,
      NA_real_
    ),
    os = str_to_lower(os),   # lowercase OS
    os_family = case_when(   # categorize OS
      str_detect(os, "win") ~ "Windows",
      str_detect(os, "mac|apple") ~ "Mac",
      str_detect(os, paste(linux, collapse ="|")) ~ "Linux",
      TRUE ~ "Other"
    )
  )

survey3 <- survey2 |> 
  select(os, os_family, distance_mi, commute_min, travel_mph)
head(survey3)


















