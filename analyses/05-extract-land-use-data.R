# Extract Land use change data
#----------------------------------------------------------
# # Either run this immediately after script 01 
# (do not clear the environment) or source
# from script 1 to get overlaps

#-----------------
# Load libraries
#-----------------
library(tidyverse) 
library(ncdf4)
library(raster) 
library(rgdal)
library(here)

source(here::here("analyses/functions-anthropocene-data.R"))
#------------------------
# List of LUH2 variables
#------------------------
#primf: forested primary land
#primn: non-forested primary land
#secdf: potentially forested secondary land
#secdn: potentially non-forested secondary land
#pastr: managed pasture
#range: rangeland
#urban: urban land
#c3ann: C3 annual crops
#c3per: C3 perennial crops
#c4ann: C4 annual crops
#c4per: C4 perennial crops
#c3nfx: C3 nitrogen-fixing crops
#secma: secondary mean age (units: years)
#secmb: secondary mean biomass density (units: kg C/m^2)

#----------------------------------
# Read in the netCDF data
#----------------------------------
# Read in the netCDF data
nc_data <- nc_open('raw-data/spatial-data/LUH2_high_states.nc')

# Capture the lat, lon and time variables
lon <- ncvar_get(nc_data, "lon")
lat <- ncvar_get(nc_data, "lat", verbose = F)
time <- ncvar_get(nc_data, "time")

# Start with overlaps then add each variable in turn
# The functions below will throw warnings about coordinate
# systems but all are in WGS84 so it's fine
## This takes 5-10 minutes to run - go and get a coffee ###
overlaps_landuse <- overlaps

# Primary forest
overlaps_landuse <- 
  get_landuse_diff("primf", nc_data, overlaps_landuse) 

# Primary non forest
overlaps_landuse <- 
  get_landuse_diff("primn", nc_data, overlaps_landuse) 

# Secondary forest
overlaps_landuse <- 
  get_landuse_diff("secdf", nc_data, overlaps_landuse) 

# Secondary non forest
overlaps_landuse <- 
  get_landuse_diff("secdn", nc_data, overlaps_landuse) 

# Pasture
overlaps_landuse <- 
  get_landuse_diff("pastr", nc_data, overlaps_landuse) 

# Rangeland
overlaps_landuse <- 
  get_landuse_diff("range", nc_data, overlaps_landuse) 

# Urban
overlaps_landuse <- 
  get_landuse_diff("urban", nc_data, overlaps_landuse) 

# Close data set 
nc_close(nc_data)

#----------------------------------
# Repeat for low LUH2 data...
#----------------------------------

#----------------------------------
# Read in the netCDF data
#----------------------------------
# Read in the netCDF data
nc_dataX <- nc_open('raw-data/spatial-data/LUH2_low_states.nc')

# Capture the lat, lon and time variables
lon <- ncvar_get(nc_dataX, "lon")
lat <- ncvar_get(nc_dataX, "lat", verbose = F)
time <- ncvar_get(nc_dataX, "time")

# Start with overlaps then add each variable in turn
# The functions below will throw warnings about coordinate
# systems but all are in WGS84 so it's fine
## This takes 5-10 minutes to run - go and get a coffee ###
overlaps_landuseX <- overlaps

# Primary forest
overlaps_landuseX <- 
  get_landuse_diff("primf", nc_dataX, overlaps_landuseX) 

# Primary non forest
overlaps_landuseX <- 
  get_landuse_diff("primn", nc_dataX, overlaps_landuseX) 

# Secondary forest
overlaps_landuseX <- 
  get_landuse_diff("secdf", nc_dataX, overlaps_landuseX) 

# Secondary non forest
overlaps_landuseX <- 
  get_landuse_diff("secdn", nc_dataX, overlaps_landuseX) 

# Pasture
overlaps_landuseX <- 
  get_landuse_diff("pastr", nc_dataX, overlaps_landuseX) 

# Rangeland
overlaps_landuseX <- 
  get_landuse_diff("range", nc_dataX, overlaps_landuseX) 

# Urban
overlaps_landuseX <- 
  get_landuse_diff("urban", nc_dataX, overlaps_landuseX) 

# Close data set 
nc_close(nc_dataX)