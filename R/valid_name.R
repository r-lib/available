#' Is a package name valid
#' @inheritParams available
#' @export
valid_package_name <- function(name) {

  # This is the algorithm used in R CMD check at
  # https://github.com/wch/r-source/blob/a3a73a730962fa214b4af0ded55b497fb5688b8b/src/library/tools/R/QC.R#L3214
  valid <- TRUE

  # check for a package called 'R'
  res <- if (tolower(name) == "r") {
    FALSE
  } else {
    grepl(glue::glue("^{valid_package_name_regexp}$"), name)
  }
  structure(res, class = "available_valid_name")
}

#' @export

format.available_valid_name <- function(x, ...) {
  paste0(crayon::bold("Name valid: "), yes_no(x[[1]]), "\n")
}

#' @export

print.available_valid_name <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

valid_package_name_regexp <-
        .standard_regexps()$valid_package_name
