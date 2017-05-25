
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/jimhester/available.svg?branch=master)](https://travi%20s-ci.org/jimhester/available)

available
=========

The goal of available is to help you determine if the package name you are considering is available to use.

Installation
------------

You can install available from github with:

``` r
# install.packages("devtools")
devtools::install_github("ropenscilabs/available")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
available::available("available")
#> Name valid: ✓ 
#> Available on CRAN: ✓ 
#> Available on Bioconductor: ✓ 
#> Available on GitHub: X 
#> Sentiment: +++
```
