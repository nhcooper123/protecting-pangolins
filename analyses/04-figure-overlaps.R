# ## Figures of overlaps
# Either run this immediately after script 01 
# (do not clear the environment) or source
# from script 1.
##----------------------------------------------
# SE function
se <- function(y) {
  return(data.frame(ymin = mean(y) - sqrt(var(y)/length(y)), 
                    ymax = mean(y) + sqrt(var(y)/length(y))))
}

##----------------------------------------------------------
# Species list
##-------------------------------------------------
species.list <- c("M. crassicaudata", 
                  "M. javanica", "M. pentadactyla",
                  "P. tetradactyla", "P. tricuspis",
                  "S. gigantea", "S. temminckii")
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
  stat_summary(fun.y = mean, geom = 'point', size = 2)

year_plota <- 
  ggplot(overlaps_year, aes(x = Year, y = Percent_overlap)) +
  geom_point() +
  xlab('collection year') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plota <- 
  ggplot(overlaps_all, aes(x = Continent, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

ecology_plota <- 
  ggplot(overlaps_all, aes(x = ecology, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('ecology') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

redlist_plota <- 
  ggplot(overlaps_all, aes(x = redlist, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('Red List status') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plota / (continent_plota + year_plota) / 
  (ecology_plota + redlist_plota)

#ggsave(here("figures/area-overlap.png"))

##-----------------------------------------------------------
# % overlap by specimen numbers
##-----------------------------------------------------------
species_plotb <- 
  ggplot(overlaps_all, aes(x = binomial, 
                           y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'black', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('% overlaps') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic"))

year_plotb <- 
  ggplot(overlaps_year, aes(x = Year, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point() +
  xlab('collection year') +
  ylab('% overlaps') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plotb <- 
  ggplot(overlaps_all, aes(x = Continent, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('% overlaps') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

ecology_plotb <- 
  ggplot(overlaps_all, aes(x = ecology, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('ecology') +
  ylab('% overlaps') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

redlist_plotb <- 
  ggplot(overlaps_all, aes(x = redlist, y = (numberOfOverlaps/numberOfSpecimens) * 100)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('Red List status') +
  ylab('% overlaps') +
  ylim(0,100) +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plotb / (continent_plotb + year_plotb) /
  (ecology_plotb + redlist_plotb)

#ggsave(here("figures/specimen-number-overlap.png"))
##-----------------------------------------------------------
# Distances
##-----------------------------------------------------------
species_plotd <- 
  ggplot(overlaps_all, aes(x = binomial, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

year_plotd <- 
  ggplot(overlaps_year, aes(x = Year, y = distance)) +
  geom_point() +
  xlab('collection year') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plotd <- 
  ggplot(overlaps_all, aes(x = Continent, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

ecology_plotd <- 
  ggplot(overlaps_all, aes(x = ecology, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('ecology') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

redlist_plotd <- 
  ggplot(overlaps_all, aes(x = redlist, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('Red List status') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plotd / (continent_plotd + year_plotd)
  / (ecology_plotd + redlist_plotd)
#ggsave(here("figures/distance-overlap.png"))

##-----------------------------------------------------------
# Extents
##-----------------------------------------------------------
species_plote <- 
  ggplot(overlaps_all, aes(x = binomial, y = Extent_km)) +
  geom_point(color = 'grey', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('extent (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

year_plote <- 
  ggplot(overlaps_year, aes(x = Year, y = Extent_km)) +
  geom_point() +
  xlab('collection year') +
  ylab('extent (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plote <- 
  ggplot(overlaps_all, aes(x = Continent, y = Extent_km)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('extent (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

ecology_plote <- 
  ggplot(overlaps_all, aes(x = ecology, y = Extent_km)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('ecology') +
  ylab('extent (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

redlist_plote <- 
  ggplot(overlaps_all, aes(x = redlist, y = Extent_km)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('Red List status') +
  ylab('extent (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plote / (continent_plote + year_plote) / (ecology_plote + redlist_plote)
#ggsave(here("figures/extent-overlap.png"))