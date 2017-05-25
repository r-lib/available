#' Get sentiment of name
#'
#' @param name Name of package to search
sentiment <- function(name) {
  sentiment_dictionary <- tidytext::get_sentiments("bing")

  res <- sentiment_dictionary[sentiment_dictionary$word == name, ][["sentiment"]]
  if (length(res) == 0) {
    res <- NA
  }
  structure(res == "positive", class = "available_sentiment")
}

print.available_sentiment <- function(x) {
  cat(crayon::bold("Sentiment:"),
    if (is.na(x[[1]])) {
      "???"
    } else if (isTRUE(x[[1]])) {
      crayon::green("\u2795")
    } else{
      crayon::red("\u2796")
    }, "\n")
}
