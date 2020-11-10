# protecting-pangolins

Author(s): [Natalie Cooper](mailto:natalie.cooper.@nhm.ac.uk), Jake Curry and Emily Buckingham.

This repository contains all the code and some data used in the [paper](add link later). 

To cite the paper: 
> Emily Buckingham, Jake Curry, Charles Emogor, Louise Tomsett and Natalie Cooper. Using natural history collections to investigate changes in pangolin (Pholidota: Manidae) geographic ranges through time. PeerJ.

To cite this repo: 
> Natalie Cooper, Jake Curry and Emily Buckingham. 2020. GitHub: nhcooper123/protecting-pangolins: code for the paper v2. Zenodo. DOI: [add doi].

[![DOI](https://zenodo.org/badge/161480153.svg)](https://zenodo.org/badge/latestdoi/161480153) [add doi badge]

## Data
All cleaned data are available from the [NHM Data Portal](https://doi.org/10.5519/0065209).
We were unable to upload most of the raw data to GitHub because the files are too large; however this data is mostly freely available to download as shown below.

If you use the cleaned data please cite as follows: 
> Emily Buckingham, Jake Curry, Charles Emogor, Louise Tomsett and Natalie Cooper (2019). Dataset: Pangolin georeferencing. Natural History Museum Data Portal (data.nhm.ac.uk). [ https://doi.org/10.5519/0058821](https://doi.org/10.5519/0058821).

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
1. **01B-overlaps-AOH-Math.Rmd** runs overlaps models and wrangles into a useable format.
1. **01C-wrangle-overlaps-outputs.Rmd** wrangles together the overlaps and specimen details datasets.
1. **02-asia_africa_figures.R** creates the maps of pangolin localities and AOH.
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
* `/data` contains the cleaned data

-------
## Session Info

    Session info ──────────────────────────────────────────────────────────────────────────
    setting  value                       
    version  R version 3.6.2 (2019-12-12)
    os       macOS Catalina 10.15.7      
    system   x86_64, darwin15.6.0        
    ui       RStudio                     
    language (EN)                        
    collate  en_GB.UTF-8                 
    ctype    en_GB.UTF-8                 
    tz       Europe/London               
    date     2020-11-10                  

    Packages ──────────────────────────────────────────────────────────────────────────────
    package       * version    date       lib source                     
    abind         * 1.4-5      2016-07-21 [1] CRAN (R 3.6.0)             
    assertthat      0.2.1      2019-03-21 [2] CRAN (R 3.6.0)             
    backports       1.1.6      2020-04-05 [1] CRAN (R 3.6.2)             
    base64enc       0.1-3      2015-07-28 [2] CRAN (R 3.6.0)             
    betareg       * 3.1-3      2020-02-03 [2] CRAN (R 3.6.0)             
    broom         * 0.7.0      2020-07-09 [1] CRAN (R 3.6.2)             
    callr           3.4.3      2020-03-28 [1] CRAN (R 3.6.2)             
    cellranger      1.1.0      2016-07-27 [2] CRAN (R 3.6.0)             
    checkmate       2.0.0      2020-02-06 [1] CRAN (R 3.6.0)             
    class           7.3-15     2019-01-01 [2] CRAN (R 3.6.2)             
    classInt        0.4-2      2019-10-17 [2] CRAN (R 3.6.0)             
    cli             2.0.2      2020-02-28 [1] CRAN (R 3.6.0)             
    cluster         2.1.0      2019-06-19 [2] CRAN (R 3.6.2)             
    codetools       0.2-16     2018-12-24 [2] CRAN (R 3.6.2)             
    colorspace      1.4-1      2019-03-18 [2] CRAN (R 3.6.0)             
    cowplot       * 1.0.0      2019-07-11 [1] CRAN (R 3.6.0)             
    crayon          1.3.4      2017-09-16 [2] CRAN (R 3.6.0)             
    data.table      1.12.8     2019-12-09 [1] CRAN (R 3.6.0)             
    DBI             1.1.0      2019-12-15 [2] CRAN (R 3.6.0)             
    dbplyr          1.4.2      2019-06-17 [2] CRAN (R 3.6.0)             
    desc            1.2.0      2018-05-01 [1] CRAN (R 3.6.0)             
    devtools        2.2.2      2020-02-17 [1] CRAN (R 3.6.0)             
    digest          0.6.25     2020-02-23 [1] CRAN (R 3.6.0)             
    dplyr         * 0.8.3      2019-07-04 [2] CRAN (R 3.6.0)             
    e1071           1.7-3      2019-11-26 [2] CRAN (R 3.6.0)             
    ellipsis        0.3.0      2019-09-20 [2] CRAN (R 3.6.0)             
    fansi           0.4.1      2020-01-08 [2] CRAN (R 3.6.2)             
    flexmix         2.3-17     2020-10-12 [2] CRAN (R 3.6.2)             
    forcats       * 0.4.0      2019-02-17 [2] CRAN (R 3.6.0)             
    foreign         0.8-72     2019-08-02 [2] CRAN (R 3.6.2)             
    Formula       * 1.2-3      2018-05-03 [1] CRAN (R 3.6.0)             
    fs              1.4.1      2020-04-04 [1] CRAN (R 3.6.2)             
    generics        0.0.2      2018-11-29 [2] CRAN (R 3.6.0)             
    ggfortify     * 0.4.8      2019-11-10 [1] CRAN (R 3.6.0)             
    ggplot2       * 3.3.0      2020-03-05 [1] CRAN (R 3.6.0)             
    glue            1.4.0      2020-04-03 [1] CRAN (R 3.6.2)             
    gridExtra       2.3        2017-09-09 [1] CRAN (R 3.6.0)             
    gtable          0.3.0      2019-03-25 [2] CRAN (R 3.6.0)             
    haven           2.2.0      2019-11-08 [2] CRAN (R 3.6.0)             
    here          * 0.1        2017-05-28 [1] CRAN (R 3.6.0)             
    Hmisc         * 4.4-1      2020-08-10 [1] CRAN (R 3.6.2)             
    hms             0.5.3      2020-01-08 [2] CRAN (R 3.6.2)             
    htmlTable       2.0.1      2020-07-05 [1] CRAN (R 3.6.2)             
    htmltools       0.4.0      2019-10-04 [2] CRAN (R 3.6.0)             
    htmlwidgets     1.5.1      2019-10-08 [1] CRAN (R 3.6.0)             
    httr            1.4.1      2019-08-05 [2] CRAN (R 3.6.0)             
    jpeg            0.1-8.1    2019-10-24 [2] CRAN (R 3.6.0)             
    jsonlite        1.6.1      2020-02-02 [1] CRAN (R 3.6.0)             
    KernSmooth      2.23-16    2019-10-15 [2] CRAN (R 3.6.2)             
    knitr         * 1.26       2019-11-12 [2] CRAN (R 3.6.0)             
    lattice       * 0.20-38    2018-11-04 [2] CRAN (R 3.6.2)             
    latticeExtra    0.6-29     2019-12-19 [1] CRAN (R 3.6.0)             
    lifecycle       0.2.0      2020-03-06 [1] CRAN (R 3.6.0)             
    lmtest        * 0.9-38     2020-09-09 [2] CRAN (R 3.6.2)             
    lubridate       1.7.4      2018-04-11 [2] CRAN (R 3.6.0)             
    lwgeom          0.2-5      2020-06-12 [1] CRAN (R 3.6.2)             
    magrittr        1.5        2014-11-22 [2] CRAN (R 3.6.0)             
    Matrix          1.2-18     2019-11-27 [2] CRAN (R 3.6.2)             
    memoise         1.1.0      2017-04-21 [1] CRAN (R 3.6.0)             
    modelr          0.1.5      2019-08-08 [2] CRAN (R 3.6.0)             
    modeltools      0.2-23     2020-03-05 [2] CRAN (R 3.6.0)             
    munsell         0.5.0      2018-06-12 [2] CRAN (R 3.6.0)             
    ncdf4         * 1.17       2019-10-23 [2] CRAN (R 3.6.0)             
    nnet            7.3-12     2016-02-02 [2] CRAN (R 3.6.2)             
    patchwork     * 1.0.0      2019-12-01 [2] CRAN (R 3.6.0)             
    pillar          1.4.3      2019-12-20 [2] CRAN (R 3.6.0)             
    pkgbuild        1.0.6      2019-10-09 [1] CRAN (R 3.6.0)             
    pkgconfig       2.0.3      2019-09-22 [2] CRAN (R 3.6.0)             
    pkgload         1.0.2      2018-10-29 [1] CRAN (R 3.6.0)             
    png             0.1-7      2013-12-03 [2] CRAN (R 3.6.0)             
    prettyunits     1.1.1      2020-01-24 [1] CRAN (R 3.6.0)             
    processx        3.4.2      2020-02-09 [1] CRAN (R 3.6.0)             
    ps              1.3.2      2020-02-13 [1] CRAN (R 3.6.0)             
    purrr         * 0.3.3      2019-10-18 [2] CRAN (R 3.6.0)             
    R6              2.4.1      2019-11-12 [2] CRAN (R 3.6.0)             
    raster        * 3.1-5      2020-04-19 [1] CRAN (R 3.6.2)             
    RColorBrewer    1.1-2      2014-12-07 [2] CRAN (R 3.6.0)             
    Rcpp            1.0.5      2020-07-06 [1] CRAN (R 3.6.2)             
    readr         * 1.3.1      2018-12-21 [2] CRAN (R 3.6.0)             
    readxl          1.3.1      2019-03-13 [2] CRAN (R 3.6.0)             
    remotes         2.1.1      2020-02-15 [1] CRAN (R 3.6.0)             
    reprex          0.3.0      2019-05-16 [2] CRAN (R 3.6.0)             
    rgdal         * 1.5-16     2020-08-07 [1] CRAN (R 3.6.2)             
    rgeos         * 0.5-2      2019-10-03 [1] CRAN (R 3.6.0)             
    rlang           0.4.7      2020-07-09 [1] CRAN (R 3.6.2)             
    rnaturalearth   0.1.0      2017-03-21 [1] CRAN (R 3.6.0)             
    rpart           4.1-15     2019-04-12 [2] CRAN (R 3.6.2)             
    rprojroot       1.3-2      2018-01-03 [1] CRAN (R 3.6.0)             
    rstudioapi      0.11       2020-02-07 [1] CRAN (R 3.6.0)             
    rvest           0.3.5      2019-11-08 [2] CRAN (R 3.6.0)             
    sandwich        3.0-0      2020-10-02 [2] CRAN (R 3.6.2)             
    scales          1.1.0      2019-11-18 [2] CRAN (R 3.6.0)             
    sessioninfo     1.1.1      2018-11-05 [1] CRAN (R 3.6.0)             
    sf            * 0.9-6      2020-09-13 [1] CRAN (R 3.6.2)             
    sfe           * 0.0.0.9001 2020-09-15 [1] Github (JCur96/sfe@5d2e5a8)
    sp            * 1.4-1      2020-02-28 [1] CRAN (R 3.6.0)             
    stars         * 0.4-3      2020-07-08 [2] CRAN (R 3.6.2)             
    stringi         1.4.6      2020-02-17 [1] CRAN (R 3.6.0)             
    stringr       * 1.4.0      2019-02-10 [2] CRAN (R 3.6.0)             
    survival      * 3.1-8      2019-12-03 [2] CRAN (R 3.6.2)             
    testthat        2.3.2      2020-03-02 [1] CRAN (R 3.6.0)             
    tibble        * 3.0.0      2020-03-30 [1] CRAN (R 3.6.2)             
    tidyr         * 1.0.0      2019-09-11 [2] CRAN (R 3.6.0)             
    tidyselect      1.1.0      2020-05-11 [1] CRAN (R 3.6.2)             
    tidyverse     * 1.3.0      2019-11-21 [1] CRAN (R 3.6.0)             
    units           0.6-5      2019-10-08 [2] CRAN (R 3.6.0)             
    usethis         1.5.1      2019-07-04 [1] CRAN (R 3.6.0)             
    vctrs           0.2.4      2020-03-10 [1] CRAN (R 3.6.0)             
    withr           2.1.2      2018-03-15 [2] CRAN (R 3.6.0)             
    xfun            0.11       2019-11-12 [2] CRAN (R 3.6.0)             
    xml2            1.2.2      2019-08-09 [2] CRAN (R 3.6.0)             
    yaml            2.2.1      2020-02-01 [1] CRAN (R 3.6.0)             
    zoo           * 1.8-7      2020-01-10 [1] CRAN (R 3.6.0)             

## Checkpoint for reproducibility
To rerun all the code with packages as they existed on CRAN at time of our analyses we recommend using the `checkpoint` package, and running this code prior to the analysis:

```{r}
checkpoint("2020-11-10")
```
