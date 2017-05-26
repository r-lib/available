#' Open wikipedia page and abbreviations.com page
#'
#' @inheritParams available
#' @export
get_wikipidia <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wikipedia.org/wiki/", name)

  structure(url, class = "available_wikipedia")
}

#' @export

format.available_wikipedia <- function(x, ...) {
  browseURL(x[[1]])
  paste0(crayon::bold("Wikipedia: "), crayon::blue(x[[1L]]), "\n")
}

#' @export

print.available_wikipedia <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

#' @rdname get_wikipidia
#' @export
get_wiktionary <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wiktionary.org/wiki/", name)

  structure(url, class = "available_wiktionary")
}

#' @export

format.available_wiktionary <- function(x) {
  browseURL(x[[1]])
  paste0(crayon::bold("Wiktionary: "), crayon::blue(x[[1L]]), "\n")
}

#' @export

print.available_wiktionary <- function(x, ...) {
  cat(format(x))
  invisible(x)
}

get_abbreviation <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("http://www.abbreviations.com/", name)

  structure(url, class = "available_abbreviation")
}

print.available_abbreviation <- function(x) {
  browseURL(x[[1]])
  cat(crayon::bold("Abbreviations: "), crayon::blue(x[[1L]]), "\n", sep = "")

  invisible(x)
}
