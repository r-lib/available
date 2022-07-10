
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![CRAN
status](http://www.r-pkg.org/badges/version/available)](https://cran.r-project.org/package=available)
[![R-CMD-check](https://github.com/r-lib/available/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-lib/available/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

<p align="center">
<img src="http://i.imgur.com/1KZn3Z5.jpg" alt="xzibit">
</p>

 

# available

> available helps you name your R package.

-   Checks for validity
-   Checks not already available on GitHub, CRAN and Bioconductor
-   Can suggest possible names based on text in the package title or
    description.

## Installation

You can install available from CRAN with:

``` r
install.packages("available")
```

Or the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("r-lib/available")
```

## Examples

<p align="center">
<img src="http://i.imgur.com/tA1VdaH.png">
</p>

 

## Generate new package names from titles

``` r
library(available)
suggest(text = "Client for New York Times APIs")
#> timesr

suggest(text = "An R Interface to SciDB")
#> scidbr
```

### Rstudio Support

RStudio versions 1.1 and later support color in the terminal.
