### Land use GIS functions

# Function to extract differences in variables from LUH2 data
# in 2014 to that in 1850, 1900, 1950 or 2000.
# varable = name of one of the variables in LUH2 in ""
# landuse_data = nc format data from states.nc of LUH2 datasets
# overlaps_data = output from script 01 with polygon geometry for error 
# point radius polygons
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

#---------------------------------
# Helper functions
#---------------------------------

# Extract file names with paths
get_files <- function(path) {
  files <- list.files(path)
  paste0(path, files)
}

# Extract file names to make into object names
get_names <- function(path) {
  files <- list.files(path)
  str_remove(files, ".asc")
}

#---------------------------------
# Function to extract differences in variables from HPD data
# in 2014 to that in 1850, 1900, 1950 or 2000.
# overlaps_data = output from script 01 with polygon geometry for error 
# point radius polygons

extract_hpd <- function(overlaps_data){
  
  # Extract difference between time slices for each variable
  diff.popc.1850 <- popc_2014AD - popc_1850AD
  diff.popd.1850 <- popd_2014AD - popd_1850AD
  diff.rurc.1850 <- rurc_2014AD - rurc_1850AD
  diff.urbc.1850 <- urbc_2014AD - urbc_1850AD
  
  diff.popc.1900 <- popc_2014AD - popc_1900AD
  diff.popd.1900 <- popd_2014AD - popd_1900AD
  diff.rurc.1900 <- rurc_2014AD - rurc_1900AD
  diff.urbc.1900 <- urbc_2014AD - urbc_1900AD
  
  diff.popc.1950 <- popc_2014AD - popc_1950AD
  diff.popd.1950 <- popd_2014AD - popd_1950AD
  diff.rurc.1950 <- rurc_2014AD - rurc_1950AD
  diff.urbc.1950 <- urbc_2014AD - urbc_1950AD
  
  diff.popc.2000 <- popc_2014AD - popc_2000AD
  diff.popd.2000 <- popd_2014AD - popd_2000AD
  diff.rurc.2000 <- rurc_2014AD - rurc_2000AD
  diff.urbc.2000 <- urbc_2014AD - urbc_2000AD
  
  # Extract mean values across raster cells for specimen error polygons
  values.popc.1850 <- raster::extract(diff.popc.1850, overlaps_data, fun = mean, na.rm = TRUE)
  values.popd.1850 <- raster::extract(diff.popd.1850, overlaps_data, fun = mean, na.rm = TRUE)
  values.rurc.1850 <- raster::extract(diff.rurc.1850, overlaps_data, fun = mean, na.rm = TRUE)
  values.urbc.1850 <- raster::extract(diff.urbc.1850, overlaps_data, fun = mean, na.rm = TRUE)
  
  values.popc.1900 <- raster::extract(diff.popc.1900, overlaps_data, fun = mean, na.rm = TRUE)
  values.popd.1900 <- raster::extract(diff.popd.1900, overlaps_data, fun = mean, na.rm = TRUE)
  values.rurc.1900 <- raster::extract(diff.rurc.1900, overlaps_data, fun = mean, na.rm = TRUE)
  values.urbc.1900 <- raster::extract(diff.urbc.1900, overlaps_data, fun = mean, na.rm = TRUE)
  
  values.popc.1950 <- raster::extract(diff.popc.1950, overlaps_data, fun = mean, na.rm = TRUE)
  values.popd.1950 <- raster::extract(diff.popd.1950, overlaps_data, fun = mean, na.rm = TRUE)
  values.rurc.1950 <- raster::extract(diff.rurc.1950, overlaps_data, fun = mean, na.rm = TRUE)
  values.urbc.1950 <- raster::extract(diff.urbc.1950, overlaps_data, fun = mean, na.rm = TRUE)
  
  values.popc.2000 <- raster::extract(diff.popc.2000, overlaps_data, fun = mean, na.rm = TRUE)
  values.popd.2000 <- raster::extract(diff.popd.2000, overlaps_data, fun = mean, na.rm = TRUE)
  values.rurc.2000 <- raster::extract(diff.rurc.2000, overlaps_data, fun = mean, na.rm = TRUE)
  values.urbc.2000 <- raster::extract(diff.urbc.2000, overlaps_data, fun = mean, na.rm = TRUE)
  
  # Create variable names
  v1 <- sym("popc_1850")
  v2 <- sym("popd_1850")
  v3 <- sym("rurc_1850")
  v4 <- sym("urbc_1850")
  
  v5 <- sym("popc_1900")
  v6 <- sym("popd_1900")
  v7 <- sym("rurc_1900")
  v8 <- sym("urbc_1900")
  
  v9 <- sym("popc_1950")
  v10 <- sym("popd_1950")
  v11 <- sym("rurc_1950")
  v12 <- sym("urbc_1950")
  
  v13 <- sym("popc_2000")
  v14 <- sym("popd_2000")
  v15 <- sym("rurc_2000")
  v16 <- sym("urbc_2000")
  
  # Add to overlaps data with names
  # Behold the glory of !!
  overlaps_data <-
    overlaps_data %>%
    mutate(!!v1 := values.popc.1850) %>%
    mutate(!!v2 := values.popd.1850) %>%
    mutate(!!v3 := values.rurc.1850) %>%
    mutate(!!v4 := values.urbc.1850) %>%
    
    mutate(!!v5 := values.popc.1900) %>%
    mutate(!!v6 := values.popd.1900) %>%
    mutate(!!v7 := values.rurc.1900) %>%
    mutate(!!v8 := values.urbc.1900) %>%
    
    mutate(!!v9 := values.popc.1950) %>%
    mutate(!!v10 := values.popd.1950) %>%
    mutate(!!v11 := values.rurc.1950) %>%
    mutate(!!v12 := values.urbc.1950) %>%
    
    mutate(!!v13 := values.popc.2000) %>%
    mutate(!!v14 := values.popd.2000) %>%
    mutate(!!v15 := values.rurc.2000) %>%
    mutate(!!v16 := values.urbc.2000) 
    
    return(overlaps_data)
  
}
