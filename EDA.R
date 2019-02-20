setwd("C:/Users/Ruichen/Desktop/DataScience/DTI")
library(readxl)
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


# Read Data
# Population - county level
population = read.csv("2010+Census+Population+By+Zipcode+(ZCTA).csv", header = T, stringsAsFactors = F)
OpioidPrescribing_D = read_excel_allsheets("Medicare_Part_D_Opioid_Prescribing_Geographic_2016.xlsx")$County
