# ## Analysing The Output
# Either run this immediately after script 01 
# (do not clear the environment) or source
# from script 1.
##----------------------------------------------------------
# Omit specimens with large extents and low certainty
##-----------------------------------------------------------
overlaps2 <-
  overlaps %>%
  filter(Certainty >= 50 & Extent_km < 50)

##----------------------------------------------------------
# Omit duplicates (years analyses)
# and add success failure numbers
##-----------------------------------------------------------
overlaps_year <-
  overlaps2 %>%
  filter(duplicates_year == FALSE)

# Add successes and failures for models
# Number of specimens per species total
overlaps_year <- countNumbSpecimens(overlaps_year)
# Number of overlaps per species
overlaps_year <- countNumbOverlaps(overlaps_year)
##----------------------------------------------------------
# Omit duplicates (other analyses)
# and add success failure numbers
##-----------------------------------------------------------
overlaps_all <-
  overlaps2 %>%
  filter(duplicates == FALSE)

# Add successes and failures for models
# Number of specimens per species total
overlaps_all <- countNumbSpecimens(overlaps_all)
# Number of overlaps per species
overlaps_all <- countNumbOverlaps(overlaps_all)

##-----------------------------------------------------------
## Model fitting - binomial overlap
##-----------------------------------------------------------
## Year
##-----------
model1 <- glm(binomial_overlap ~ Year, data = overlaps_year,
              family = binomial)

## Model diagnostics
plot(model1)

## Model outputs
anova(model1, test = "Chi")
summary(model1)

##-----------
## Continent
##-----------
model2 <- glm(binomial_overlap ~ Continent, data = overlaps_all,
             family = binomial)
## Model diagnostics
plot(model2)

## Model outputs
anova(model2, test = "Chi")
summary(model2)

##-----------
## Ecology
##-----------
model3 <- glm(binomial_overlap ~ ecology, data = overlaps_all,
             family = binomial)

## Model diagnostics
plot(model3)

## Model outputs
anova(model3, test = "Chi")
summary(model3)

##-----------
## IUCN
##-----------
model4 <- glm(binomial_overlap ~ redlist, data = overlaps_all,
             family = binomial)
## Model diagnostics
plot(model4)

## Model outputs
anova(model4, test = "Chi")
summary(model4)

##-----------
## Species
##-----------
model5 <- glm(binomial_overlap ~ binomial, data = overlaps_all,
             family = binomial)
## Model diagnostics
plot(model5)

## Model outputs
anova(model5, test = "Chi")
summary(model5)

##-----------------------------------------------------------
## Model fitting - with % overlaps of area
##-----------------------------------------------------------
## Year
##-----------
model1a <- lm(Percent_overlap ~ Year, data = overlaps_year)

## Model diagnostics
plot(model1a)

## Model outputs
anova(model1a)
summary(model1a)

##-----------
## Continent
##-----------
model2a <- lm(Percent_overlap ~ Continent, data = overlaps_all)

## Model diagnostics
plot(model2a)

## Model outputs
anova(model2a)
summary(model2a)

##-----------
## Ecology
##-----------
model3a <- lm(Percent_overlap ~ ecology, data = overlaps_all)

## Model diagnostics
plot(model3a)

## Model outputs
anova(model3a)
summary(model3a)

##-----------
## IUCN
##-----------
model4a <- lm(Percent_overlap ~ redlist, data = overlaps_all)

## Model diagnostics
plot(model4a)

## Model outputs
anova(model4a)
summary(model4a)

##-----------
## Species
##-----------
model5a <- lm(Percent_overlap ~ binomial, data = overlaps_all)

## Model diagnostics
plot(model5a)

## Model outputs
anova(model5a)
summary(model5a)

##-----------------------------------------------------------
## Model fitting - distances
##-----------------------------------------------------------
## Year
##-----------
model1b <- lm(log(distance) ~ Year, data = overlaps_year)

## Model diagnostics
plot(model1b)

## Model outputs
anova(model1b)
summary(model1b)

##-----------
## Continent
##-----------
model2b <- lm(log(distance) ~ Continent, data = overlaps_all)

## Model diagnostics
plot(model2b)

## Model outputs
anova(model2b)
summary(model2b)

##-----------
## Ecology
##-----------
model3b <- lm(log(distance) ~ ecology, data = overlaps_all)

## Model diagnostics
plot(model3b)

## Model outputs
anova(model3b)
summary(model3b)

##-----------
## IUCN
##-----------
model4b <- lm(log(distance) ~ redlist, data = overlaps_all)

## Model diagnostics
plot(model4b)

## Model outputs
anova(model4b)
summary(model4b)

##-----------
## Species
##-----------
model5b <- lm(log(distance) ~ binomial, data = overlaps_all)

## Model diagnostics
plot(model5b)

## Model outputs
anova(model5b)
summary(model5b)

##-----------------------------------------------------------
## Model fitting - with extents...
##-----------------------------------------------------------
## Year
##-----------
model1c <- lm(log(Extent_km) ~ Year, data = overlaps_year)

## Model diagnostics
plot(model1c)

## Model outputs
anova(model1c)
summary(model1c)

##-----------
## Continent
##-----------
model2c <- lm(log(Extent_km) ~ Continent, data = overlaps_all)

## Model diagnostics
plot(model2c)

## Model outputs
anova(model2c)
summary(model2c)

##-----------
## Ecology
##-----------
model3c <- lm(log(Extent_km) ~ ecology, data = overlaps_all)

## Model diagnostics
plot(model3c)

## Model outputs
anova(model3c)
summary(model3c)

##-----------
## IUCN
##-----------
model4c <- lm(log(Extent_km) ~ redlist, data = overlaps_all)

## Model diagnostics
plot(model4c)

## Model outputs
anova(model4c)
summary(model4c)

##-----------
## Species
##-----------
model5c <- lm(log(Extent_km) ~ binomial, data = overlaps_all)

## Model diagnostics
plot(model5c)

## Model outputs
anova(model5c)
summary(model5c)

output <- data.frame(array(dim = c()))
names(output) <-
  



