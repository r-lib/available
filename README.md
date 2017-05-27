
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/available.svg?branch=master)](https://travis-ci.org/ropenscilabs/available)

available
=========

The goal of available is to help you choose a good name for your R package. It helps you determine if the package name you are considering is available to use (on GitHub, CRAN and Bioconductor), checks Urban Dictionary to make sure you haven't unintentionally chosen a bad word, searches for the name on Wikipedia, checks the sentiment of your chosen name and lets you know about packages with similar names. It can also suggest a possible name for your package based on its title or a short description of what it does.

Installation
------------

You can install available from github with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/available")
```

Examples
--------

<p align="center">
<img src="http://i.imgur.com/tA1VdaH.png">
</p>

Generate new package names from titles
--------------------------------------

``` r
library(available)
suggest(title = "Client for New York Times APIs")
#> [1] "york"

suggest(title = "An R Interface to SciDB")
#> [1] "scidb"
```

### Rstudio Support

In order to have color in the RStudio terminal you need a [daily build of RStudio](https://dailies.rstudio.com/) and development versions of the **rstudioapi** and **crayon** packages.

``` r
devtools::install_github("rstudio/rstudioapi")
devtoosl::install_github("gaborcsardi/crayon")
```
