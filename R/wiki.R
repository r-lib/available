#' Open wikipedia page and abbreviations.com page
#'
#' @inheritParams available
#' @export
get_wikipedia <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wikipedia.org/wiki/", name)

  structure(url, class = "available_wikipedia")
}

#' @export
format.available_wikipedia <- function(x, ...) {
  browseURL(x[[1]])
  paste0(cli::style_bold("Wikipedia: "), cli::format_inline("{.url {x[[1L]]}}"), "\n")
}

#' @export
print.available_wikipedia <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

#' @rdname get_wikipedia
#' @export
get_wiktionary <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wiktionary.org/wiki/", name)

  structure(url, class = "available_wiktionary")
}

#' @export
format.available_wiktionary <- function(x, ...) {
  browseURL(x[[1]])
  paste0(cli::style_bold("Wiktionary: "), cli::format_inline("{.url {x[[1L]]}}"), "\n")
}

#' @export
print.available_wiktionary <- function(x, ...) {
  cat(format(x))
  invisible(x)
}

get_abbreviation <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://www.abbreviations.com/", name)

  structure(url, class = "available_abbreviation")
}

#' @export
print.available_abbreviation <- function(x, ...) {
  browseURL(x[[1]])
  cat(cli::style_bold("Abbreviations: "), cli::format_inline("{.url {x[[1L]]}}"), "\n", sep = "")

  invisible(x)
}
