#' Get sentiment of name
#'
#' @param name Name of package to search
#' @export
get_sentiment <- function(name) {
  # Workaround for https://github.com/juliasilge/tidytext/issues/64
  ("base" %:::% "library")("tidytext")
  on.exit(detach("package:tidytext"))
  sentiment_dictionary <- tidytext::get_sentiments("bing")

  res <- sentiment_dictionary[sentiment_dictionary$word == name, ][["sentiment"]]
  if (length(res) == 0) {
    res <- NA
  }
  structure(res == "positive", class = "available_sentiment")
}

#' @export

format.available_sentiment <- function(x, ...) {
  paste0(
    crayon::bold("Sentiment:"),
    if (is.na(x[[1]])) {
      "???"
    } else if (isTRUE(x[[1]])) {
      crayon::green("+++")
    } else {
      crayon::red("---")
    },
    "\n"
  )
}

#' @export

print.available_sentiment <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}
