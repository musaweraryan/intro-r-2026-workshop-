library(dplyr)
library(tidyr)
library(leaflet)
library(sf)
library(tigris)

raw_stations <- read.csv("data/raw/stations.csv", stringsAsFactors = F)

stations <- raw_stations |> 
  filter(end_date == "") |> 
  select(
    stationid,
    locationtext,
    lon,
    lat,
    milepost,
    agency
  )

stations_map <- stations |> 
  filter(lon != -1) |> 
  leaflet() |> 
  addProviderTiles(providers$CartoDB.Positron) |> 
  addCircleMarkers(
    lng = ~lon,
    lat = ~lat,
    color = "purple",
    radius = 2,
    popup = ~paste(
      "Stationid:", stationid, "<br>",
      "Description:", locationtext, "<br>",
      "Agency:", agency, "<br>",
      "MP:", milepost
    )
  )

stations_map


# Get VA counties
va_counties <- counties(state = "VA", cb = TRUE, class = "sf")

# Transform CRS to WGS84
va_counties <- st_transform(va_counties, crs = '+proj=longlat +datum=WGS84')

# Leaflet map
va_county_map <- va_counties |> 
  leaflet() |> 
  addProviderTiles(providers$CartoDB.Positron) |> 
  addPolygons(
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
    popup = ~paste("NAME:", NAME)
  )

va_county_map














