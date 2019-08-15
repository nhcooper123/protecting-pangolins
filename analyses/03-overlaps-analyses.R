# ## Analysing The Output
# Either run this immediately after script 01 
# (do not clear the environment) or source
# from script 1.
##----------------------------------------------

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
### leave everything but year, lat, long, error?


##----------------------------------------------------------
# Omit duplicates (other analyses)
##-----------------------------------------------------------

##-----------------------------------------------------------
## Model fitting
##-----------------------------------------------------------
## Year
##-----------
model2 <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                Year, data = overlaps2, family = 'binomial')

## Check for overdispersion (should be < 2)
sum_model2 <- summary(model2)
sum_model2$deviance / sum_model2$df.resid

## Model diagnostics
plot(model2)

## Model outputs
anova(model2, test = "Chisq")
summary(model2)

##-----------
## Continent
##-----------
model3 <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                Continent, data = overlaps2, family = 'binomial')

## Check for overdispersion (should be < 2)
sum_model3 <- summary(model3)
sum_model3$deviance / sum_model3$df.resid

## Model diagnostics
plot(model3)

## Model outputs
anova(model3, test = "Chisq")
summary(model3)

##-----------
## Ecology
##-----------
model4 <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                Habitat, data = overlaps2, family = 'binomial')

## Check for overdispersion (should be < 2)
sum_model4 <- summary(model4)
sum_model4$deviance / sum_model4$df.resid

## Model diagnostics
plot(model4)

## Model outputs
anova(model4, test = "Chisq")
summary(model4)

##-----------
## IUCN
##-----------
model5 <- glm(cbind(numberOfOverlaps, (numberOfSpecimens - numberOfOverlaps)) ~
                RedList, data = overlaps2, family = 'binomial')

## Check for overdispersion (should be < 2)
sum_model5 <- summary(model5)
sum_model5$deviance / sum_model5$df.resid

## Model diagnostics
plot(model5)

## Model outputs
anova(model5, test = "Chisq")
summary(model5)