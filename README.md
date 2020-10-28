# protecting-pangolins

Author(s): [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk) and Jake Curry.

This repository contains all the code and some data used in the [paper](add link later). 

To cite the paper: 
> Emilly Buckingham, Jake Curry, Charles Emogor, Louise Tomsett and Natalie Cooper. Using natural history collections to investigate changes in pangolin (Pholidota: Manidae) geographic ranges through time. PeerJ.

To cite this repo: 
> Natalie Cooper and Jake Curry. 2020. GitHub: nhcooper123/protecting-pangolins: code for the paper v2. Zenodo. DOI: [add doi].

[![DOI](https://zenodo.org/badge/161480153.svg)](https://zenodo.org/badge/latestdoi/161480153) [add doi badge]

## Data
All cleaned data are available from the [NHM Data Portal](https://doi.org/10.5519/0065209).
We were unable to upload most of the raw data to GitHub because the files are too large; however this data is mostly freely available to download as shown below.

If you use the cleaned data please cite as follows: 
> Emilly Buckingham, Jake Curry, Charles Emogor, Louise Tomsett and Natalie Cooper (2019). Dataset: Pangolin georeferencing. Natural History Museum Data Portal (data.nhm.ac.uk). [ https://doi.org/10.5519/0058821](https://doi.org/10.5519/0058821).

Please also cite the original sources of the data as follows:

> GBIF. 2019. GBIF.org (08 August 2019) GBIF Occurrence Download. Available from https://doi.org/10.15468/dl.o1t25o [8 August 2019].

> IUCN range maps and extinction risk categories. IUCN 2020. The IUCN Red List of Threatened Species. Version 2019-2. Available from http://www.iucnredlist.org [September 2020].

> Land use data: Hurtt G., Chini L., Sahajpal R., Frolking S., Fisk J., Bodirsky B., Calvin K.V., Fujimori S., Goldewijk K., Hasegawa T., Havlik P., Heinimann A., Humpenöder F., Kaplan J.O., Krisztin T., Lawrence D. M., Lawrence P., Mertz O., Popp A., Riahi K. Stehfest E., van Vuuren D., de Waal L., Zhang X., in prep. Harmonization of global land-use change and management for the period 850-2100. Geosci. Model Devel. Available from https://luh.umd.edu/data.shtml [10 October 2020].

> Human population density data: Goldewijk K., Beusen A., Doelman J., Stehfest, E., 2017. Anthropogenic land-use estimates for the Holocene; HYDE 3.2. Earth Syst. Sci. Data. 9: 927-953.

-------
## Analyses
The analysis code is divided into `.Rmd` files that run the analyses for each section of the paper/supplementary materials, and more detailed scripts for the figures found in the paper.

Note that throughout I've commented out `ggsave` commands so you don't clog your machine up with excess plots you don't need.

1. **01A-wrangle-data.Rmd** wrangles the specimen data into a useable format.
1. **01B-extract-overlaps.Rmd** runs overlaps models and wrangles into a useable format.
1. **01C-wrangle-overlaps-outputs.Rmd** wrangles together the overlaps and specimen details datasets.
1. **02-figure-maps.R** creates the maps of pangolin localities.
1. **03-overlaps-analyses.Rmd** gets summary stats about % overlaps.
1. **04-overlaps-analyses-models.Rmd** runs models of overlaps against various predictors.
1. **05-figures-overlaps.R** creates overlaps figures.
1. **06-extract-land-use-data.Rmd** extracts appropriate land use data from the rasters.
1. **07-land-use-analyses.Rmd** runs models of overlaps against various land use predictors.
1. **08-extract-population-data.Rmd** extracts appropriate HPD data from the rasters.
1. **09-hpd-analyses.Rmd** runs models of overlaps against various HPD predictors.
1. **10-figures-anthro.R** creates figures of anthropogenic variables.
1. **functions-anthropocene-data.R** functions to make scripts 6-10 work.

-------
## Other folders

* `/figures` contains the figures

-------
## Session Info


## Checkpoint for reproducibility
To rerun all the code with packages as they existed on CRAN at time of our analyses we recommend using the `checkpoint` package, and running this code prior to the analysis:

```{r}
checkpoint("2020-11-06")
```
