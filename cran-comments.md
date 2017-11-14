This is a resubmission. In this version I have added examples for the `available()`
and `suggest()` functions.

It was noted in the previous submission that running `available()` opens
a handful of browser windows.

Users can disable this by passing `browse = FALSE` to
`available()` or by setting `options("available.browse" = FALSE)` to disable
them globally. I feel having this option default to `TRUE` is the correct
choice as inspecting the information in the opened pages is one of the primary
purposes of the package.

## Test environments
* local OS X install, R 3.4.2
* ubuntu 14.04 (on travis-ci), R 3.4.2
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
