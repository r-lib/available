
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/available.svg?branch=master)](https://travis-ci.org/ropenscilabs/available) [![CRAN status](http://www.r-pkg.org/badges/version/available)](https://cran.r-project.org/package=available)
<p align="center">
<img src="http://i.imgur.com/1KZn3Z5.jpg" alt="xzibit">
</p>
 

available
=========

> available helps you name your R package.

-   Checks for validity
-   Checks not already available on GitHub, CRAN and Bioconductor
-   Searches Urban Dictionary, Wiktionary and Wikipedia for unintended meanings
-   Can suggest possible names based on text in the package title or description.

Installation
------------

You can install available from CRAN with:

``` r
install.packages("availabe")
```

Or the development version from GitHub with:

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
#> [1] "times"

suggest(title = "An R Interface to SciDB")
#> [1] "scidb"
```

### Rstudio Support

In order to have color in the RStudio terminal you need a [daily build of RStudio](https://dailies.rstudio.com/) and development versions of the **rstudioapi** and **crayon** packages.

``` r
devtools::install_github("rstudio/rstudioapi")
devtools::install_github("gaborcsardi/crayon")
```
