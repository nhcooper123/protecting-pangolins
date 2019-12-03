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
  read_csv(here("data/overlaps.csv")) 

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
  xlim(0, 14) +
  ylim(0, 100) +
  labs(title = "1850") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popc_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("log pop count") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 14) +
  labs(title = "1900") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popc_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 14) +
  labs(title = "1950") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1850 <- 
  ggplot(overlaps_all, aes(x = log(popd_1850), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1850") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popd_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("log pop density") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1900") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popd_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1950") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

(pop_plot_1850 + pop_plot_1900 + pop_plot_1950) / 
  (popd_plot_1850 + popd_plot_1900 + popd_plot_1950)

#ggsave(here("figures/popsize-overlap.png"), width = 5)

##-----------------------------------------------------------
# % area overlap plots population
##-----------------------------------------------------------
pop_plot_1850 <- 
  ggplot(overlaps_all, aes(x = log(popc_1850), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  xlim(0, 14) +
  ylim(0, 100) +
  labs(title = "1850") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popc_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("log pop count") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 14) +
  labs(title = "1900") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

pop_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popc_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 14) +
  labs(title = "1950") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1850 <- 
  ggplot(overlaps_all, aes(x = log(popd_1850), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1850") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1900 <- 
  ggplot(overlaps_all, aes(x = log(popd_1900), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("log pop density") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1900") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

popd_plot_1950 <- 
  ggplot(overlaps_all, aes(x = log(popd_1950), y = Percent_overlap)) +
  geom_point(alpha = 0.5) +
  xlab("") +
  ylab('% overlap') +
  theme_bw(base_size = 14) +
  ylim(0, 100) +
  xlim(0, 10) +
  labs(title = "1950") +
  theme(plot.title = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12))

(pop_plot_1850 + pop_plot_1900 + pop_plot_1950) / 
  (popd_plot_1850 + popd_plot_1900 + popd_plot_1950)

#ggsave(here("figures/popsize-overlap.png"), width = 5)