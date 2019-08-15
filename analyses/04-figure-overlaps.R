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
# Omit specimens with large extents and low certainty
##-----------------------------------------------------------
overlaps2 <-
  overlaps %>%
  filter(Certainty >= 50 & Extent_km < 50)  

##----------------------------------------------------------
# Omit duplicates (years analyses)
##-----------------------------------------------------------
#overlaps3 <-
#  overlaps %>%
# select(-RegistrationNumber) 
### leave everything but year, lat, long, error? then take distinct?


##----------------------------------------------------------
# Omit duplicates (other analyses)
##-----------------------------------------------------------


##-----------------------------------------------------------
# % area overlap plots
##-----------------------------------------------------------
species_plota <- 
  ggplot(overlaps2, aes(x = binomial, y = Percent_overlap)) +
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
  ggplot(overlaps2, aes(x = Year, y = Percent_overlap)) +
  geom_point() +
  xlab('collection year') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plota <- 
  ggplot(overlaps2, aes(x = Continent, y = Percent_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plota / (continent_plota + year_plota)

#ggsave(here("figures/area-overlap.png"))
##-----------------------------------------------------------
# Binomial overlap plots
##-----------------------------------------------------------
species_plotb <- 
  ggplot(overlaps2, aes(x = binomial, y = binomial_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('overlap (binary)') +
  theme_bw(base_size = 14) +
  ylim(0, 1) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2) 

year_plotb <- 
  ggplot(overlaps2, aes(x = Year, y = binomial_overlap)) +
  geom_point() +
  xlab('collection year') +
  ylab('overlap (binary)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plotb <- 
  ggplot(overlaps2, aes(x = Continent, y = binomial_overlap)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('overlap (binary)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plotb / (continent_plotb + year_plotb)

#ggsave(here("figures/binary-overlap.png"))
##-----------------------------------------------------------
# Centroid distance plots
##-----------------------------------------------------------
species_plotc <- 
  ggplot(overlaps2, aes(x = binomial, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  scale_x_discrete(labels = species.list) +
  xlab("") +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, 
                                   face = "italic")) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

year_plotc <- 
  ggplot(overlaps2, aes(x = Year, y = distance)) +
  geom_point() +
  xlab('collection year') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plotc <- 
  ggplot(overlaps2, aes(x = Continent, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plotc / (continent_plotc + year_plotc)

#ggsave(here("figures/distance-overlap.png"))
##-----------------------------------------------------------
# % overlap by specimen numbers
##-----------------------------------------------------------

species_plotd <- 
  ggplot(overlaps2, aes(x = binomial, y = distance)) +
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
  ggplot(overlaps2, aes(x = Year, y = distance)) +
  geom_point() +
  xlab('collection year') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

continent_plotd <- 
  ggplot(overlaps2, aes(x = Continent, y = distance)) +
  geom_point(color = 'grey', alpha = 0.5) +
  xlab('continent') +
  ylab('centroid distance (km)') +
  theme_bw(base_size = 14) +
  stat_summary(fun.data = se, geom = 'errorbar', width = 0.2) +
  stat_summary(fun.y = mean, geom = 'point', size = 2)

species_plotd / (continent_plotd + year_plotd)

#ggsave(here("figures/distance-overlap.png"))