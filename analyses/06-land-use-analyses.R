# Land use change analyses

## Requires overlaps_landuse from script 04
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

modela <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                primf, data = overlaps_landuse_all, family = 'binomial')

## Check for overdispersion (should be < 2)
sum_model2 <- summary(model2)
sum_model2$deviance / sum_model2$df.resid

## Model diagnostics
plot(model2)

## Model outputs
anova(model2, test = "Chisq")
summary(model2)


##-----------------------------------------------------------
## Model fitting - with % overlaps of area
##-----------------------------------------------------------

model2a <- lm(Percent_overlap ~ primf, data = overlaps_all)

## Model diagnostics
plot(model2a)

## Model outputs
anova(model2a)
summary(model2a)
