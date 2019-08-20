# Land use change analyses

## Requires overlaps_landuse from script 05

###
# Prep data
##----------------------------------------------------------
# Omit specimens with large extents and low certainty
##-----------------------------------------------------------
overlaps_landuse2 <-
  overlaps_landuse %>%
  filter(Certainty >= 50 & Extent_km < 50)

##----------------------------------------------------------
# Omit duplicates
# and add success failure numbers
##-----------------------------------------------------------
overlaps_landuse_all <-
  overlaps_landuse2 %>%
  filter(duplicates == FALSE)

# Add successes and failures for models
# Number of specimens per species total
overlaps_landuse_all <- countNumbSpecimens(overlaps_landuse_all)
# Number of overlaps per species
overlaps_landuse_all <- countNumbOverlaps(overlaps_landuse_all)

##------------------------------------------------------------------
## Model fitting - binomial GLMs with no overlaps vs not per species
##------------------------------------------------------------------
# Fit model for all land use variables...
binomial_output <- data.frame(array(dim = c(28, 5)))
names(binomial_output) <- c("variable", "df1", "df2", "res.dev", "p")

for(i in 16:43){
  
modela <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                overlaps_landuse_all[ , i][[1]], data = overlaps_landuse_all, family = 'binomial')

## Model outputs
z <- anova(modela, test = "Chisq")
summary(modela)

binomial_output$variable[i-15] <- names(overlaps_landuse_all)[i]
binomial_output$df1[i-15] <- z$Df[2]
binomial_output$df2[i-15] <- z$`Resid. Df`[2]
binomial_output$res.dev[i-15] <- z$`Resid. Dev`[2] 
binomial_output$p[i-15] <- z$`Pr(>Chi)`[2]  

}
# Save outputs
write_csv(path = here::here("outputs/landuse_binomial_output_high.csv"), binomial_output)
##-----------------------------------------------------------
## Model fitting - with % overlaps of area
##-----------------------------------------------------------
percent_output <- data.frame(array(dim = c(28, 5)))
names(percent_output) <- c("variable", "df1", "df2", "F", "p")

for(i in 16:43){
  
  modela <- lm(Percent_overlap ~ overlaps_landuse_all[ , i][[1]], 
               data = overlaps_landuse_all)
  
  ## Model outputs
  z <- anova(modela)
  
  percent_output$variable[i-15] <- names(overlaps_landuse_all)[i]
  percent_output$df1[i-15] <- z$Df[1]
  percent_output$df2[i-15] <- z$Df[2]
  percent_output$F[i-15] <- z$`F value`[1] 
  percent_output$p[i-15] <- z$`Pr(>F)`[1]  
  
}

# Save outputs
write_csv(path = here::here("outputs/landuse_percent_output_high.csv"), percent_output)

# Quick plot
ggplot(overlaps_landuse_all, aes(x = primf_1850, y = Percent_overlap)) +
  geom_point() +
  xlab('diff') +
  ylab('% area overlap') +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6))

#----------------------------------------------------------------------
### Repeat for low LUH2 data

# Prep data
##----------------------------------------------------------
# Omit specimens with large extents and low certainty
##-----------------------------------------------------------
overlaps_landuse2X <-
  overlaps_landuseX %>%
  filter(Certainty >= 50 & Extent_km < 50)

##----------------------------------------------------------
# Omit duplicates
# and add success failure numbers
##-----------------------------------------------------------
overlaps_landuse_allX <-
  overlaps_landuse2X %>%
  filter(duplicates == FALSE)

# Add successes and failures for models
# Number of specimens per species total
overlaps_landuse_allX <- countNumbSpecimens(overlaps_landuse_allX)
# Number of overlaps per species
overlaps_landuse_allX <- countNumbOverlaps(overlaps_landuse_allX)

##------------------------------------------------------------------
## Model fitting - binomial GLMs with no overlaps vs not per species
##------------------------------------------------------------------
# Fit model for all land use variables...
binomial_outputX <- data.frame(array(dim = c(28, 5)))
names(binomial_outputX) <- c("variable", "df1", "df2", "res.dev", "p")

for(i in 16:43){
  
  modela <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                  overlaps_landuse_allX[ , i][[1]], data = overlaps_landuse_allX, family = 'binomial')
  
  ## Model outputs
  z <- anova(modela, test = "Chisq")
  summary(modela)
  
  binomial_outputX$variable[i-15] <- names(overlaps_landuse_allX)[i]
  binomial_outputX$df1[i-15] <- z$Df[2]
  binomial_outputX$df2[i-15] <- z$`Resid. Df`[2]
  binomial_outputX$res.dev[i-15] <- z$`Resid. Dev`[2] 
  binomial_outputX$p[i-15] <- z$`Pr(>Chi)`[2]  
  
}
# Save outputs
write_csv(path = here::here("outputs/landuse_binomial_output_low.csv"), binomial_outputX)
##-----------------------------------------------------------
## Model fitting - with % overlaps of area
##-----------------------------------------------------------
percent_outputX <- data.frame(array(dim = c(28, 5)))
names(percent_outputX) <- c("variable", "df1", "df2", "F", "p")

for(i in 16:43){
  
  modela <- lm(Percent_overlap ~ overlaps_landuse_allX[ , i][[1]], 
               data = overlaps_landuse_allX)
  
  ## Model outputs
  z <- anova(modela)
  
  percent_outputX$variable[i-15] <- names(overlaps_landuse_allX)[i]
  percent_outputX$df1[i-15] <- z$Df[1]
  percent_outputX$df2[i-15] <- z$Df[2]
  percent_outputX$F[i-15] <- z$`F value`[1] 
  percent_outputX$p[i-15] <- z$`Pr(>F)`[1]  
  
}

# Save outputs
write_csv(path = here::here("outputs/landuse_percent_output_low.csv"), percent_outputX)