### Land use GIS functions

# Function to extract differences in variables from LUH2 data
# in 2014 to that in 1850, 1900, 1950 or 2000.
# varable = name of one of the variables in LUH2 in ""
# landuse_data = nc format data from states.nc of LUH2 datasets
# overlaps_data = output from script 01 with polygon geometry for error 
# poitn radius polygons
get_landuse_diff <- function(variable, landuse_data, overlaps_data){
  
  # Extract array for one variable
  # Store the data in a 3-dimensional array
  var.array <- ncvar_get(landuse_data, variable) 
  
  # Time is the third dimension of array. 
  # Extract for 1850, 1900, 1950, 2000 and 2014
  var.slice.1850 <- var.array[, , 1001] 
  var.slice.1900 <- var.array[, , 1051] 
  var.slice.1950 <- var.array[, , 1101]
  var.slice.2000 <- var.array[, , 1101]
  var.slice.2014 <- var.array[, , 1151] 
  
  # Extract difference between time slices
  var.diff.1850 <- var.slice.2014 - var.slice.1850
  var.diff.1900 <- var.slice.2014 - var.slice.1900
  var.diff.1950 <- var.slice.2014 - var.slice.1950
  var.diff.2000 <- var.slice.2014 - var.slice.2000
  
  # Save the difference as a raster.
  raster.diff.1850 <- 
    raster(t(var.diff.1850), xmn = min(lon), xmx = max(lon), 
           ymn = min(lat), ymx = max(lat),
           crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  
  raster.diff.1900 <- 
    raster(t(var.diff.1900), xmn = min(lon), xmx = max(lon), 
           ymn = min(lat), ymx = max(lat),
           crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  
  raster.diff.1950 <- 
    raster(t(var.diff.1950), xmn = min(lon), xmx = max(lon), 
           ymn = min(lat), ymx = max(lat),
           crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  
  raster.diff.2000 <- 
    raster(t(var.diff.2000), xmn = min(lon), xmx = max(lon), 
           ymn = min(lat), ymx = max(lat),
           crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  
  # Extract mean values across raster cells for specimen error polygons
  values.1850 <- raster::extract(raster.diff.1850, overlaps_data, fun = mean, na.rm = TRUE)
  values.1900 <- raster::extract(raster.diff.1900, overlaps_data, fun = mean, na.rm = TRUE)
  values.1950 <- raster::extract(raster.diff.1950, overlaps_data, fun = mean, na.rm = TRUE)
  values.2000 <- raster::extract(raster.diff.2000, overlaps_data, fun = mean, na.rm = TRUE)
  
  # Create variable names
  v1 <- sym(paste0(variable, "_1850"))
  v2 <- sym(paste0(variable, "_1900"))
  v3 <- sym(paste0(variable, "_1950"))
  v4 <- sym(paste0(variable, "_2000"))
  
  # Add to overlaps data with names
  # Behold the glory of !!
  overlaps_data <-
    overlaps_data %>%
    mutate(!!v1 := values.1850) %>%
    mutate(!!v2 := values.1900) %>%
    mutate(!!v3 := values.1950) %>%
    mutate(!!v4 := values.2000) 
  
  return(overlaps_data)
  
}
