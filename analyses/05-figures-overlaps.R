# ## Figures of overlaps
# Oct 2020

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
  read_csv(here("data/overlaps_combined.csv")) %>%  
  mutate(redlist = factor(redlist, levels = c("VU", "EN", "CR"))) %>%
  filter(Certainty >= 50 & Extent_km < 50) %>%
  filter(duplicates == 0) %>%
  # Number of specimens per species total
  countNumbSpecimens() %>%
  # Number of overlaps per species
  countNumbOverlaps()

## Years data
overlaps_year <- 
  read_csv(here("data/overlaps_combined.csv")) %>%  
  mutate(redlist = factor(redlist, levels = c("VU", "EN", "CR"))) %>%
  filter(Certainty >= 50 & Extent_km < 50) %>%
  filter(duplicates_year == 0) %>%
  # Number of specimens per species total
  countNumbSpecimens() %>%
  # Number of overlaps per species
  countNumbOverlaps()
##-----------------------------------------------------------
# % area overlap plots
##-----------------------------------------------------------
species_plota <- 
  ggplot(overlaps_all, aes(x = binomial, y =  Percent_overlap)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.25) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  #ylim(0, 100) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2)  +
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

year_plota <- 
  ggplot(overlaps_year, aes(x = Year, y = Percent_overlap)) +
  geom_point(colour = "grey", alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))  +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

continent_plota <- 
  ggplot(overlaps_all, aes(x = Continent, y = Percent_overlap)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2)  +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

ecology_plota <- 
  ggplot(overlaps_all, aes(x = ecology, y = Percent_overlap)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2)  +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

redlist_plota <- 
  ggplot(overlaps_all, aes(x = redlist, y = Percent_overlap)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2) +
  labs(tag = "E") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

species_plota / (year_plota + continent_plota) / 
  (ecology_plota + redlist_plota)

# Warning message refers to 38 points with no Year data

#ggsave(here("figures/area-overlap_revision.png"), width = 5, height = 6)

##-----------------------------------------------------------
# % overlap by specimen numbers
##-----------------------------------------------------------
species_plotb <- 
  ggplot(overlaps_all, aes(x = binomial, 
                           y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.25) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('% overlap') +
  coord_cartesian(ylim = c(80, 100)) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic"))+
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

year_plotb <- 
  ggplot(overlaps_year, aes(x = Year, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(colour = "grey", alpha = 0.5) +
  xlab('') +
  ylab('% overlap') +
  coord_cartesian(ylim = c(80, 100)) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

continent_plotb <- 
  ggplot(overlaps_all, aes(x = Continent, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  coord_cartesian(ylim = c(80, 100)) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2) +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

ecology_plotb <- 
  ggplot(overlaps_all, aes(x = ecology, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  coord_cartesian(ylim = c(80, 100)) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2) +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

redlist_plotb <- 
  ggplot(overlaps_all, aes(x = redlist, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_jitter(color = 'grey', alpha = 0.5, width = 0.1) +
  xlab('') +
  ylab('% overlap') +
  coord_cartesian(ylim = c(80, 100)) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun = mean, geom = 'point', size = 2) +
  labs(tag = "E") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

species_plotb / (year_plotb + continent_plotb) /
  (ecology_plotb + redlist_plotb)

#ggsave(here("figures/specimen-number-overlap_revision.png"), width = 5, height = 8)
