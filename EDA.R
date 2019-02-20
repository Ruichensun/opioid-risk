setwd("C:/Users/Ruichen/Desktop/DataScience/DTI")
library(readxl)
library(ggplot2)
library(tidyverse)
library(fiftystater)
library(mapproj)
data("fifty_states")
# Note: Using 2016 data as the year for demo

# Utility Functions

# 1. Read all sheets from excel 
# https://stackoverflow.com/questions/12945687/read-all-worksheets-in-an-excel-workbook-into-an-r-list-with-data-frames
  read_excel_allsheets <- function(filename, tibble = FALSE) {
    # data.frames
    sheets <- readxl::excel_sheets(filename)
    x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
    if(!tibble) x <- lapply(x, as.data.frame)
    names(x) <- sheets
    return (x)
  }

# 2. Part of the plotting script is adapted from https://github.com/wmurphyrd/fiftystater

# Read Data
# Population - county level
population = read.csv("2010+Census+Population+By+Zipcode+(ZCTA).csv", header = T, stringsAsFactors = F)
# Opioid Prescriging Data - Medicare Part D - 2016
OpioidPrescribing_D = read_excel_allsheets("Medicare_Part_D_Opioid_Prescribing_Geographic_2016.xlsx")$County

crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
p <- ggplot(crimes, aes(map_id = state)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = Assault), map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") +
  theme(legend.position = "bottom", 
        panel.background = element_blank())

p