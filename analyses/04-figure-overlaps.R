# ## Figures of overlaps
# Nov 2019

##----------------------------------------------
# Prep
##----------------------------------------------
## Load libraries
library(sf)
library(sfe)
library(tidyverse)
library(here)
library(patchwork)

# SE function
se <- function(y) {
  return(data.frame(ymin = mean(y) - sqrt(var(y)/length(y)), 
                    ymax = mean(y) + sqrt(var(y)/length(y))))
}

# Species list
species.list <- c("M. crassicaudata", "M.culionensis",
                  "M. javanica", "M. pentadactyla",
                  "P. tetradactyla", "P. tricuspis",
                  "S. gigantea", "S. temminckii")

##-----------------------------------------------------
# Read in the data and set coordinate ref system. 
# For some reason st_read makes everything a factor so 
# convert Extent etc back to numeric first.
# and relevel redlist
##-----------------------------------------------------
overlaps_all <- 
  st_read(here("data/overlaps.csv")) %>%  
  st_set_crs(4326) %>%
  mutate_at(vars(Extent_km, Certainty, Year, Decade,
                 Percent_overlap, binomial_overlap), 
            ~as.numeric(as.character(.))) %>%
  mutate(redlist = factor(redlist, levels = c("VU", "EN", "CR"))) %>%
  # Omit poor accuracy specimens
  filter(Certainty >= 50 & Extent_km < 50) %>%
  # Omit duplicates 
  filter(duplicates == 0) %>%
  # Add successes and failures for models
  countNumbSpecimens() %>%
  # Number of overlaps per species
  countNumbOverlaps()

## Years data
overlaps_year <- 
  st_read(here("data/overlaps.csv")) %>%  
  st_set_crs(4326) %>%
  mutate_at(vars(Extent_km, Certainty, Year, Decade,
                 Percent_overlap, binomial_overlap), 
            ~as.numeric(as.character(.))) %>%
  mutate(redlist = factor(redlist, levels = c("VU", "EN", "CR"))) %>%
  # Omit poor accuracy specimens
  filter(Certainty >= 50 & Extent_km < 50) %>%
  # Omit duplicates 
  filter(duplicates_year == 0) %>%
  # Add successes and failures for models
  countNumbSpecimens() %>%
  countNumbOverlaps()

##-----------------------------------------------------------
# % area overlap plots
##-----------------------------------------------------------
species_plota <- 
  ggplot(overlaps_all, aes(x = binomial, y =  Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)  +
  labs(tag = "a") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

year_plota <- 
  ggplot(overlaps_year, aes(x = Year, y = Percent_overlap)) +
  geom_point() +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))  +
  labs(tag = "b") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

continent_plota <- 
  ggplot(overlaps_all, aes(x = Continent, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)  +
  labs(tag = "c") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

ecology_plota <- 
  ggplot(overlaps_all, aes(x = ecology, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)  +
  labs(tag = "d") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

redlist_plota <- 
  ggplot(overlaps_all, aes(x = redlist, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2) +
  labs(tag = "e") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

species_plota / (year_plota + continent_plota) / 
  (ecology_plota + redlist_plota)

#ggsave(here("figures/area-overlap.png"), width = 5)

##-----------------------------------------------------------
# % overlap by specimen numbers
##-----------------------------------------------------------
species_plotb <- 
  ggplot(overlaps_all, aes(x = binomial, 
                           y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'black', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('% overlap') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic"))+
  labs(tag = "a") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

year_plotb <- 
  ggplot(overlaps_year, aes(x = Year, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point() +
  xlab('') +
  ylab('% overlap') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) +
  labs(tag = "b") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

continent_plotb <- 
  ggplot(overlaps_all, aes(x = Continent, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2) +
  labs(tag = "c") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

ecology_plotb <- 
  ggplot(overlaps_all, aes(x = ecology, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2) +
  labs(tag = "d") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

redlist_plotb <- 
  ggplot(overlaps_all, aes(x = redlist, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2) +
  labs(tag = "e") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

species_plotb / (year_plotb + continent_plotb) /
  (ecology_plotb + redlist_plotb)

#ggsave(here("figures/specimen-number-overlap.png"), width = 5)