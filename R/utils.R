"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

yes_no <- function(x) {
  if (isTRUE(x)) {
    cli::col_green(cli::symbol$tick)
  } else {
    cli::col_red(cli::symbol$cross)
  }
}

fix_windows_nl <- function(x) {
  gsub("\r\n", "\n", x)
}

glue_collapse <- function(...) {
  if (utils::packageVersion("glue") > "1.2.0") {
    utils::getFromNamespace("glue_collapse", "glue")(...)
  } else {
    utils::getFromNamespace("collapse", "glue")(...)
  }
}

#' @exportS3Method testthat::compare
compare.glue <- function(x, y) {
  if (identical(class(y), "character")) {
    class(x) <- NULL
  }
  NextMethod("compare")
}

compact <- function(x) {
  len <- lengths(x)
  x[!len == 0]
}
