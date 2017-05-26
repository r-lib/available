
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropenscilabs/available.svg?branch=master)](https://travis-ci.org/ropenscilabs/available)

available
=========

The goal of available is to help you choose a good name for your R package. It helps you determine if the package name you are considering is available to use (on GitHub, CRAN and Bioconductor), checks Urban Dictionary to make sure you haven't unintentionally chosen a bad word, searches for the name on Wikipedia, checks the sentiment of your chosen name and lets you know about packages with similar names. It can also suggest a possible names for your package based on its title or a short description of what it does.

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
