#' See if a name is available
#'
#' Searches performed
#' - Valid package name
#' - Already taken on CRAN
#' - Positive or negative sentiment
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
#' @export
available <- function(name, ...) {
  c(
    valid_package_name(name),
    available_on_cran(name, ...),
    get_sentiment(name))
}
