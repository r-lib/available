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
  res <- list(valid_package_name(name),
    available_on_cran(name, ...),
    available_on_bioc(name, ...),
    available_on_github(name))
  terms <- name_to_search_terms(name)
  res <- c(res,
    unlist(recursive = FALSE,
      lapply(terms,
      function(term) {
        list(
          get_bad_words(term),
          get_abbreviation(term),
          get_wikipidia(term),
          get_wiktionary(term),
          get_urban_data(term),
          sentiment(term))
          })))
    structure(res, class = "available_query")
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
    if (!requireNamespace("devtools")) {
      stop("`devtools` must be installed to create a package", call. = FALSE)
    }
    devtools::create(name, ...)
  }
}

#' Suggest a title based for a development package
#'
#' If the package you are using already has a title, simply pass the path to
#' the package root in `path`. Otherwise use `title` to specify a potential
#' title.
#' @param path Path to a existing package to extract the title from.
#' @param title title string to search.
#' @export
suggest <- function(path = ".", title = NULL) {
  if (is.null(title)) {
    title <- unname(desc::desc(path)$get("Title"))
    if (is.na(title)) {
      stop("No title found, please specify one with `title`.", call. = FALSE)
    }
  }

  pick_word_from_title(title)
}
