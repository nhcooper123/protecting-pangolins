library(tidyverse)

ds <- read_delim("raw-data/gbif-aug-2019.csv", delim = "\t")

names(ds)

zz <-
  ds %>%
  filter(institutionCode != "NHMUK") %>%
  filter(!is.na(genus)) %>%
  filter(!is.na(species)) %>%
  filter(!is.na(locality) | !is.na(decimalLatitude)) %>%
  filter(basisOfRecord != "HUMAN_OBSERVATION") %>%
  unite(RegistrationNumber, c(institutionCode, catalogNumber)) %>%
  select(RegistrationNumber, species, countryCode, locality, 
         decimalLatitude, decimalLongitude, year, coordinateUncertaintyInMeters, issue) %>%
  distinct()

# Additional 294 specimens BUT many zoo species
