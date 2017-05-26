#' See if a name is available
#'
#' Searches performed
#' - Valid package name
#' - Already taken on CRAN
#' - Positive or negative sentiment
#' - Urban Dictionary
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
#' @importFrom memoise memoise
#' @export
available <- function(name, ...) {
  structure(list(
    valid_package_name(name),
    available_on_cran(name, ...),
    available_on_bioc(name, ...),
    available_on_github(name),
    get_bad_words(name_to_search_terms(name)),
    get_wikipidia(name),
    get_wiktionary(name),
    get_urban_data(name),
    sentiment(name)),
    class = "available_query")
}

print.available_query <- function(x) {
  for (i in x) {
    print(i)
  }
  invisible(x)
}

#' Check a new package name and possibly create it
#'
#' @inheritParams available
#' @param ... Additional arguments passed to [devtools::create()].
create <- function(name, ...) {
  print(available(name))

  ans <- yesno::yesno(glue::glue("Create package `{name}`?"))
  if (isTRUE(ans)) {
    if (!requiredNamespace("devtools")) {
      stop("`devtools` must be installed to create a package", call. = FALSE)
    }
    devtools::create(name, ...)
  }
}
