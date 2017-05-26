#' Open wikipedia page and abbreviations.com page
#'
#' @inheritParams available
#' @export
get_wikipidia <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wikipedia.org/wiki/", name)

  structure(url, class = "available_wikipedia")
}

print.available_wikipedia <- function(x) {
  browseURL(x[[1]])
  cat(crayon::bold("Wikipedia: "), x[[1L]], "\n", sep = "")

  invisible(x)
}

#' @rdname get_wikipidia
#' @export
get_wiktionary <- function(name) {
  # TODO: handle case when we can't open browser
  url <- paste0("https://en.wiktionary.org/wiki/", name)

  structure(url, class = "available_wiktionary")
}

print.available_wiktionary <- function(x) {
  browseURL(x[[1]])
  cat(crayon::bold("Wikipedia: "), x[[1L]], "\n", sep = "")

  invisible(x)
}
