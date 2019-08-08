library(tidyverse)

ds <- read_delim("raw-data/gbif-aug-2019.csv", delim = "\t")

names(ds)

zz <-
  ds %>%
  filter(institutionCode != "NHMUK") %>%
  filter(!is.na(genus)) %>%
  filter(!is.na(species)) %>%
  filter(basisOfRecord != "HUMAN_OBSERVATION") %>%
  filter(is.na(decimalLatitude)) %>%
  filter(!is.na(locality)) %>%
  select(scientificName, locality, year, catalogNumber) %>%
  distinct()

# Additional 294 specimens BUT many zoo species
