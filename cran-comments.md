## Test environments
* local OS X install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* Package suggested but not available for checking: ‘BiocInstaller’ Package

This note cannot be removed as BiocInstaller is unavailable in R 3.6, but
needed for prior support of R versions prior to 3.5.
