# Make maps for figure 1/2
# Either run this immediately after script 01 
# (do not clear the environment) or source
# from script 1.
##----------------------------------------------
# Helper functions for plotting
remove_y <- 
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

remove_x <-   
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
##----------------------------------------------
# Split into African and Asian species
# Remove huge extents > 1000km
##----------------------------------------------
specs_africa <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla" |
         binomial == "Phataginus tricuspis" |
         binomial == "Smutsia gigantea" |
         binomial == "Smutsia temminckii")

specs_asia <-
  specs %>%
  filter(Extent_km < 1000) %>%
  filter(binomial != "Phataginus tetradactyla" &
           binomial != "Phataginus tricuspis" &
           binomial != "Smutsia gigantea" &
           binomial != "Smutsia temminckii")

specs_errors_africa <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial == "Phataginus tetradactyla" |
           binomial == "Phataginus tricuspis" |
           binomial == "Smutsia gigantea" |
           binomial == "Smutsia temminckii")

specs_errors_asia <-
  specs_errors %>%
  filter(Extent_km < 1000) %>%
  filter(binomial != "Phataginus tetradactyla" &
           binomial != "Phataginus tricuspis" &
           binomial != "Smutsia gigantea" &
           binomial != "Smutsia temminckii")

iucn_africa <-
  iucn %>%
  filter(binomial == "Phataginus tetradactyla" |
           binomial == "Phataginus tricuspis" |
           binomial == "Smutsia gigantea" |
           binomial == "Smutsia temminckii")

iucn_asia <-
  iucn %>%
  filter(binomial != "Phataginus tetradactyla" &
           binomial != "Phataginus tricuspis" &
           binomial != "Smutsia gigantea" &
           binomial != "Smutsia temminckii")

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
africa <-
  ggplot(baseMap) +
  geom_sf() +
  geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
          data = specs_errors_africa, show.legend = FALSE) +
  geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA,
          data = iucn_africa, show.legend = FALSE) +
  geom_sf(alpha = 1, fill = "black", 
          data = specs_africa, show.legend = FALSE) +
  coord_sf(xlim = xlim_af, ylim = ylim_af, expand = TRUE) +
  theme_bw() +
  remove_x +
  remove_y +
  facet_wrap(~binomial, ncol = 2) +
  theme(strip.background = element_rect(fill = "white"),
        strip.text.x = element_text(size = 10, face = "italic"))
africa
  
# Asian species  
  asia <-
    ggplot(baseMap) +
    geom_sf() +
    geom_sf(alpha = 0.5, fill = "#7fcdbb", colour = NA,
            data = specs_errors_asia, show.legend = FALSE) +
    geom_sf(alpha = 0.5, fill = "#2c7fb8", colour = NA, 
            data = iucn_asia, show.legend = FALSE) +
    geom_sf(alpha = 1, fill = "black", 
            data = specs_asia, show.legend = FALSE) +
    coord_sf(xlim = xlim_as, ylim = ylim_as, expand = TRUE) +
  theme_bw() +
    remove_x +
    remove_y +
    facet_wrap(~binomial, ncol = 2) +
    theme(strip.background = element_rect(fill = "white"),
          strip.text.x = element_text(size = 10, face = "italic"))
asia

# Save plots  
#ggsave(here("figures/african-maps.png"), africa)
#ggsave(here("figures/asian-maps.png"), asia)
