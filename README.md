
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/available.svg?branch=master)](https://travis-ci.org/ropenscilabs/available)

available
=========

The goal of available is to help you choose a good name for your R package. It can help you determine if the package name you are considering is available to use (both on GitHub, CRAN and Bioconductor), check to make sure you haven't unintenionally chosen a bad word by checking Urban Dictionary and searches for the name on Wikipedia. It can also suggest a possible package name from the title of your package.

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
available::available("available")
#> Name valid: ✓ 
#> Available on CRAN: ✓ 
#> Available on Bioconductor: ✓ 
#> Available on GitHub: X 
#> Sentiment: +++
```
