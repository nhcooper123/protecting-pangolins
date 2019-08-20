#-----------------
# Load libraries
#-----------------
library(tidyverse) 
library(raster) 
library(rgdal)
library(here)

source(here::here("analyses/functions-anthropocene-data.R"))
#------------------------------------
# Read in hpd data for high scenario
#-------------------------------------
paths <- get_files("raw-data/spatial-data/Population_high/")

files <- get_files(path = paste0(paths, "/"))
filenames <- get_names(path = paths)

for (i in 1:length(files)){
  assign(filenames[i], raster(files[i], crs = "+proj=longlat +datum=WGS84"))}

#------------------------------------
overlaps_hpd <- extract_hpd(overlaps)
