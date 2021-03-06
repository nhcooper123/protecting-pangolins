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
# Read in the data and relevel redlist
##-----------------------------------------------------
overlaps_hpd <- 
  read_csv(here("data/overlaps_hpd.csv")) %>%  
  mutate(redlist = factor(redlist, levels = c("VU", "EN", "CR")))

overlaps_landuse <- 
  read_csv(here("data/overlaps_landuse.csv")) %>%  
  dplyr::select(RegistrationNumber, primf_1850:urban_1950)

## Join
overlaps_anthro <- 
  overlaps_hpd %>%
  full_join(overlaps_landuse)

## Next read in overlaps data so we can get the number of overlaps
overlaps <- 
  read_csv(here("data/overlaps_combined.csv")) 

overlaps <- 
  as.data.frame(overlaps) %>%
  dplyr::select(RegistrationNumber, Percent_overlap)

overlaps_all <- left_join(overlaps_anthro, overlaps, 
                          by = "RegistrationNumber")

##-----------------------------------------------------------
# % area overlap plots population
##-----------------------------------------------------------
pop_plot_1850 <- 
  ggplot(overlaps_all, aes(x = log(popc_1850), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  xlim(0, 15) +
  coord_cartesian(ylim = c(0, 100)) +
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popc_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("ln(population count)") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(0, 15) +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popc_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(0, 15) +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1850 <- 
  ggplot(overlaps_all, aes(x = log(popd_1850), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  scale_x_continuous(breaks = c(0, 5, 10)) +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popd_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("ln(population density)") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  scale_x_continuous(breaks = c(-5, 0, 5, 10)) +
  labs(tag = "E") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popd_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  scale_x_continuous(breaks = c(-5, 0, 5, 10)) +
  labs(tag = "F") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

(pop_plot_1850 + pop_plot_1900 + pop_plot_1950) / 
  (popd_plot_1850 + popd_plot_1900 + popd_plot_1950)

#ggsave(here("figures/popsize-overlap_revision.png"), width = 7, height = 6)

##-----------------------------------------------------------
# % area overlap plots landuse
##-----------------------------------------------------------
primf_plot_1850 <- 
  ggplot(overlaps_all, aes(x = primf_1850, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  xlim(-0.8, 0) +
  coord_cartesian(ylim = c(0, 100)) +
  labs(tag = "A") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

primf_plot_1900 <- 
  ggplot(overlaps_all, aes(x = primf_1900, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("primary forest") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(-0.8, 0) +
  labs(tag = "B") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

primf_plot_1950 <- 
  ggplot(overlaps_all, aes(x = primf_1950, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(-0.8, 0) +
  labs(tag = "C") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

primn_plot_1850 <- 
  ggplot(overlaps_all, aes(x = primn_1850, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  xlim(-0.8, 0) +
  coord_cartesian(ylim = c(0, 100)) +
  labs(tag = "D") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

primn_plot_1900 <- 
  ggplot(overlaps_all, aes(x = primn_1900, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("primary non-forest") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(-0.8, 0) +
  labs(tag = "E") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

primn_plot_1950 <- 
  ggplot(overlaps_all, aes(x = primn_1950, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(-0.8, 0) +
  labs(tag = "F") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

urb_plot_1850 <- 
  ggplot(overlaps_all, aes(x = urban_1850, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  #xlim(-0.8, 0) +
  coord_cartesian(ylim = c(0, 100)) +
  labs(tag = "G") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

urb_plot_1900 <- 
  ggplot(overlaps_all, aes(x = urban_1900, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("urban land") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(0, 0.6) +
  labs(tag = "H") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

urb_plot_1950 <- 
  ggplot(overlaps_all, aes(x = urban_1950, y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  coord_cartesian(ylim = c(0, 100)) +
  xlim(0, 0.6) +
  labs(tag = "I") +
  theme(plot.tag = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

# Plot
(primf_plot_1850 + primf_plot_1900 + primf_plot_1950) / 
  (primn_plot_1850 + primn_plot_1900 + primn_plot_1950) /
  (urb_plot_1850 + urb_plot_1900 + urb_plot_1950)

#ggsave(here("figures/landuse-overlap_revision.png"), width = 7, height = 8)

