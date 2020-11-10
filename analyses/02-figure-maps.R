# Make maps for figure 1/2
# Oct 2020

## Load libraries
library(sfe)
library(rgeos)
library(rgdal)
library(Hmisc)
library(tidyverse)
library(here)
library(patchwork)

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
## Read in the AOH data and transform
# One per species - should write a function...
##------------------------------------------------
aoh_mcu <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
                layer = 'Manis_culionensis_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_mja <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Manis_javanica_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_mpe <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Manis_pentadactyla_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_mcr <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Manis_crassicaudata_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_pte <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Phataginus_tetradactyla_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_ptr <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Phataginus_tricuspis_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_sgi <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Smutsia_gigantea_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

aoh_ste <- 
  readOGR(dsn = here("raw-data/AOH_shpFiles"), 
          layer = 'Smutsia_temminckii_aoh') %>%
  st_as_sf() %>%
  st_transform(4326)

##------------------------------------------------
## Read in the data and set coordinate ref system
## For some reason st_read makes everything a 
## factor so convert Extent back to numeric...
##------------------------------------------------
specs <- 
  st_read(here("data/specimens-points.csv")) %>%  
  st_set_crs(4326) %>%
  mutate(Extent_km = as.numeric(as.character(Extent_km)))

specs_errors <- 
  st_read(here("data/specimens-extents.csv")) %>%  
  st_set_crs(4326) %>%
  mutate(Extent_km = as.numeric(as.character(Extent_km)))

##----------------------------------------------
# Split into species
# Remove huge extents > 1000km
# Specimen point localities
##----------------------------------------------
specs_pte <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla")

specs_ptr <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tricuspis")

specs_sgi <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia gigantea")

specs_ste <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia temminckii")

specs_mcu <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis culionensis")

specs_mcr <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis crassicaudata")

specs_mja <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis javanica")

specs_mpe <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis pentadactyla")

##----------------------------------------------
# Split into species
# Remove huge extents > 1000km
# Specimen error extents
##----------------------------------------------
specs_errors_pte <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla")

specs_errors_ptr <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tricuspis")

specs_errors_sgi <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia gigantea")

specs_errors_ste <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Smutsia temminckii")

specs_errors_mcu <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis culionensis")

specs_errors_mcr <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis crassicaudata")

specs_errors_mja <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis javanica")

specs_errors_mpe <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Manis pentadactyla")

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
# African species
##-------------------------------------------------
## Phataginus tetradactyla
##-------------------------------------------------
pte <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_pte, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA,
          data = aoh_pte, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_pte, show.legend = FALSE) +
  coord_sf(xlim = xlim_af, ylim = ylim_af, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
##-------------------------------------------------
# Phataginus tricuspis
##-------------------------------------------------
ptr <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_ptr, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA,
          data = aoh_ptr, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_ptr, show.legend = FALSE) +
  coord_sf(xlim = xlim_af, ylim = ylim_af, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
##-------------------------------------------------
# Smutsia gigantea
##-------------------------------------------------
sgi <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_sgi, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA,
          data = aoh_sgi, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_sgi, show.legend = FALSE) +
  coord_sf(xlim = xlim_af, ylim = ylim_af, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
##-------------------------------------------------
# Smutsia temmincki
##-------------------------------------------------
ste <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_ste, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA,
          data = aoh_ste, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_ste, show.legend = FALSE) +
  coord_sf(xlim = xlim_af, ylim = ylim_af, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

(pte + ptr)/(sgi + ste) 
  
# Save plots  
# ggsave(here("figures/african-maps_revision.png"))
##-------------------------------------------------
# Asian species  
##-------------------------------------------------
# Manis crassicaudata
##-------------------------------------------------
mcr <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_mcr, show.legend = FALSE) +
    geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA, 
            data = iucn_mcr, show.legend = FALSE) +
    geom_sf(alpha = 1, fill = "black", size = 0.5,
            data = specs_mcr, show.legend = FALSE) +
    coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
    theme_bw() +
    remove_x +
    remove_y +
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
##-------------------------------------------------
# Manis culionensis
##-------------------------------------------------
## Add different limits for the small range 
mcu_bbox <- c(115, 5, 
              125, 15)

xlim_mcu <- c(mcu_bbox[1], mcu_bbox[3])
ylim_mcu <- c(mcu_bbox[2], mcu_bbox[4])

mcu <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_mcu, show.legend = FALSE) +
    geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA, 
            data = aoh_mcu, show.legend = FALSE) +
    geom_sf(alpha = 1, fill = "black", size = 0.5,
            data = specs_mcu, show.legend = FALSE) +
    coord_sf(xlim = xlim_mcu, ylim = ylim_mcu, expand = TRUE) +
    theme_bw() +
    remove_x +
    remove_y +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

##-------------------------------------------------
# Manis javanica
##-------------------------------------------------  
mja <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_mja, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA, 
          data = aoh_mja, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_mja, show.legend = FALSE) +
  coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
##-------------------------------------------------
# Manis pentadactyla
##------------------------------------------------- 
mpe <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_mpe, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA, 
          data = iucn_mpe, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", size = 0.5,
          data = specs_mpe, show.legend = FALSE) +
  coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))
  
(mcr + mcu)/(mja + mpe) 

# Save plots  
# ggsave(here("figures/asian-maps_revision.png"))
