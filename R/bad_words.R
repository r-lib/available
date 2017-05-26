bad_words <- memoise::memoise(function() {
  url <- "https://raw.githubusercontent.com/web-mech/badwords/master/lib/lang.json"

  words <- jsonlite::fromJSON(url)[[1]]
  # remove non-alphanumerics
  words <- gsub("[^[:alnum:]]", "", words)
  # remove blank and short strings
  words <- words[nchar(words) > 2]

  unique(words)
})

#' Check for bad words in name
#'
#' @inheritParams available
#' @export
#' @seealso See \url{https://github.com/web-mech/badwords}
get_bad_words <- function(name) {
  # check each bad word to see if in package name
  bad <- grepl(glue::collapse(bad_words(), "|"), name)

  structure(name[bad], class = "available_bad_words")
}

print.available_bad_words <- function(x) {
  cat(crayon::bold("Bad Words: "),
    if (length(x) == 0) {
      crayon::green(clisymbols::symbol$tick)
    } else {
      crayon::red(glue::collapse(x, sep = ", ", last = " and "))
    }, "\n", sep = "")
}
