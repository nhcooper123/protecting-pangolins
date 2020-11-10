# Asia_africa_figures
# Emily Buckingham Nov 2020

## Load libraries
library(sfe)
library(rgeos)
library(rgdal)
library(Hmisc)
library(tidyverse)
library(here)
library(patchwork)
library(raster)
library(cowplot)

##----------------------------------------------
# Helper functions for plotting
##----------------------------------------------
remove_y <- 
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

remove_x <-   
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

##------------------------------------------------
## Read in the AOH data rasters and convert to
## data frames
##------------------------------------------------
cra <- raster("crassicaudata_aoh.tif")
cra_pts <- rasterToPoints(cra, spatial = TRUE)
cra_df  <- data.frame(cra_pts)
rm(cra, cra_pts)

jav <- raster("javanica_aoh.tif")
jav_pts <- rasterToPoints(jav, spatial = TRUE)
jav_df  <- data.frame(jav_pts)
rm(jav, jav_pts)

pen <- raster("pentadactyla_aoh.tif")
pen_pts <- rasterToPoints(pen, spatial = TRUE)
pen_df  <- data.frame(pen_pts)
rm(pen, pen_pts)

cul <- raster("culionensis_aoh.tif")
cul_pts <- rasterToPoints(cul, spatial = TRUE)
cul_df  <- data.frame(cul_pts)
rm(cul, cul_pts)

tri <- raster("tricuspis_aoh.tif")
tri_pts <- rasterToPoints(tri, spatial = TRUE)
tri_df  <- data.frame(tri_pts)
rm(tri, tri_pts)

tet <- raster("tetradactyla_aoh.tif")
tet_pts <- rasterToPoints(tet, spatial = TRUE)
tet_df  <- data.frame(tet_pts)
rm(tet, tet_pts)

gig <- raster("gigantea_aoh.tif")
gig_pts <- rasterToPoints(gig, spatial = TRUE)
gig_df  <- data.frame(gig_pts)
rm(gig, gig_pts)

tem <- raster("temminckii_aoh.tif")
tem_pts <- rasterToPoints(tem, spatial = TRUE)
tem_df  <- data.frame(tem_pts)
rm(tem, tem_pts)

##------------------------------------------------
## Read in the data and set coordinate ref system
## For some reason st_read makes everything a 
## factor so convert Extent back to numeric...
##------------------------------------------------
specs <- 
  st_read(here("specimens-points.csv")) %>%  
  st_set_crs(4326) %>%
  mutate(Extent_km = as.numeric(as.character(Extent_km)))

specs_errors <- 
  st_read(here("specimens-extents.csv")) %>%  
  st_set_crs(4326) %>%
  mutate(Extent_km = as.numeric(as.character(Extent_km)))

##----------------------------------------------
# Split into African and Asian species
# Remove huge extents > 1000km
##----------------------------------------------
specs_cra <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis crassicaudata")

specs_jav <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis javanica")

specs_pen <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis pentadactyla")

specs_cul <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis culionensis")

specs_tri <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tricuspis")

specs_tet <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla")

specs_gig <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia gigantea")

specs_tem <- 
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia temminckii")

specs_errors_cra <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis crassicaudata")

specs_errors_jav <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis javanica")

specs_errors_pen <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis pentadactyla")

specs_errors_cul <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis culionensis")

specs_errors_tri <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tricuspis")

specs_errors_tet <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla")

specs_errors_gig <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia gigantea")

specs_errors_tem <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia temminckii")

##----------------------------------------------
# Make a base map of the land
##----------------------------------------------
baseMap <- 
  rnaturalearth::ne_countries(returnclass = 'sf') %>%
  st_union()

##-------------------------------------------------
## Choose coordinates to limit Africa and Asia maps
##-------------------------------------------------
# puts the coords into the order expected down in ggmap coords
africa_bbox <- c(-14.414063, -37.996163, 
                  53.613281, 27.994401)

xlim_af <- c(africa_bbox[1], africa_bbox[3])
ylim_af <- c(africa_bbox[2], africa_bbox[4])

asia_bbox <- c(68, -10, 
                 130, 40)

xlim_as <- c(asia_bbox[1], asia_bbox[3])
ylim_as <- c(asia_bbox[2], asia_bbox[4])

##-------------------------------------------------
# Make maps
##-------------------------------------------------
## Manis crassicaudata example 
  mcr <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_cra, show.legend = FALSE) +
    geom_raster(data = cra_df, aes(x = x, y = y), fill = "#2c7fb8", alpha = 0.5) +
    geom_sf(alpha = 1, fill = "black", size = 0.5,
            data = specs_cra, show.legend = FALSE) +
    coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
    theme_bw() +
    remove_x +
    remove_y +
    theme(strip.background = element_rect(fill = "white"),
          strip.text.x = element_text(size = 10, face = "italic")) +
    labs(tag = "A") +
    theme(plot.tag = element_text(face = "bold"))

## Making culionensis plot with inset
mcu_redbox <- data.frame(xmin = 116, xmax = 121, ymin = 7, ymax = 13)
mcu_bbox <- c(116, 7, 
                 121, 13)
xlim_mcu <- c(mcu_bbox[1], mcu_bbox[3])
ylim_mcu <- c(mcu_bbox[2], mcu_bbox[4])

mcu <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_cul, show.legend = FALSE) +
    geom_raster(data = cul_df, aes(x = x, y = y), fill = "#2c7fb8", alpha = 0.5) +
    geom_sf(alpha = 1, fill = "black", size = 0.5,
            data = specs_cul, show.legend = FALSE) +
    geom_rect(data = mcu_redbox, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), alpha=0, colour="red", size = 1, linetype=1) +
    coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
    theme_bw() +
    remove_x +
    remove_y +
    theme(strip.background = element_rect(fill = "white"),
          strip.text.x = element_text(size = 10, face = "italic")) +
    labs(tag = "B") +
    theme(plot.tag = element_text(face = "bold"))

mcu_inset <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_cul, show.legend = FALSE) +
    geom_raster(data = cul_df, aes(x = x, y = y), fill = "#2c7fb8", alpha = 0.5) +
    geom_sf(alpha = 1, fill = "black", size = 0.5,
            data = specs_cul, show.legend = FALSE) +
    coord_sf(xlim = xlim_mcu, ylim = ylim_mcu, expand = TRUE) +
    theme_bw() +
    remove_x +
    remove_y +
    theme(plot.background = element_rect(fill = "transparent", colour = NA))
  
mcu_final = ggdraw(plot = mcu) +
  draw_plot(mcu_inset, x = -0.015, y = 0.045, width = 0.6, height = 0.6)

## Create plot and save
asia <- cowplot::plot_grid(mcr, mcu_final, mja, mpe, nrow = 2)
africa <- cowplot::plot_grid(pte, ptr, sgi, ste, nrow = 2)
ggsave(here("asia_plot.png"), asia)
ggsave(here("africa_plot.png"), africa)