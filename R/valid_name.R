#' Is a package name valid
#' @export
valid_package_name <- function(name) {

  # This is the algorithm used in R CMD check at
  # https://github.com/wch/r-source/blob/a3a73a730962fa214b4af0ded55b497fb5688b8b/src/library/tools/R/QC.R#L3214
  valid <- TRUE

  # check for a package called 'R'
  res <- if (tolower(name) == "r") {
    FALSE
  } else {
    grepl(valid_package_name_regexp, name)
  }
  structure(res, class = "available_valid_name")
}

print.available_valid_name <- function(x) {
  cat(crayon::bold("Name valid:"), yes_no(x[[1]]), "\n")
}

valid_package_name_regexp <-
        .standard_regexps()$valid_package_name
