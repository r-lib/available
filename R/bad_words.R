#' List of bad words
#'
#' @note See \url{https://github.com/web-mech/badwords}


bad_words <- memoise::memoise(function() {
  url <- "https://raw.githubusercontent.com/web-mech/badwords/master/lib/lang.json"

  words <- jsonlite::fromJSON(url)[[1]]
  # remove non-alphanumerics
  words <- gsub("[^[:alnum:]]", "", words)
  # remove blank and short strings
  words <- words[nchar(words)>2]

})

#' Check for bad words in name
#'
#' @inheritParams available
#' @export
check_bad_words <- function(name) {
  # check each bad word to see if in package name
  check <- vapply(bad_words(), function(word) {
    stringr::str_detect(name, word)
  }, logical(1))

  if(any(check)) {
    bad <- bad_words()[check]
    stop(
      sprintf("Your package name includes the bad word(s): %s", paste0(bad, collapse = ", ")),
      call. = FALSE
    )
  }

  print("Your package name does not include any bad words")
  invisible(TRUE)
}
