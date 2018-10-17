
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/available.svg?branch=master)](https://travis-ci.org/ropenscilabs/available) [![CRAN status](http://www.r-pkg.org/badges/version/available)](https://cran.r-project.org/package=available)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
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
install.packages("available")
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
suggest(text = "Client for New York Times APIs")
#> [1] "timesr"

suggest(text = "An R Interface to SciDB")
#> [1] "scidbr"
```

### Rstudio Support

RStudio versions 1.1 and later support color in the terminal.
