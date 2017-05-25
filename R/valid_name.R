# Algorithm used in R CMD check at
# https://github.com/wch/r-source/blob/a3a73a730962fa214b4af0ded55b497fb5688b8b/src/library/tools/R/QC.R#L3214
valid_package_name <- function(name) {
  valid <- TRUE
# check for a package called 'R'
  if (tolower(name) == "r") {
    FALSE
  } else {
    grepl(valid_package_name_regexp, name)
  }
}

valid_package_name_regexp <-
        .standard_regexps()$valid_package_name
