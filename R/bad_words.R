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
  bad <- grepl(glue_collapse(bad_words(), "|"), name)

  structure(name[bad], class = "available_bad_words")
}

#' @export

format.available_bad_words <- function(x, ...) {
  good <- cli::col_green
  bad <- cli::combine_ansi_styles(cli::bg_red, cli::col_white)
  cli::cat_line(
    cli::style_bold("Bad Words: "),
    if (length(x) == 0) {
      good(cli::symbol$tick)
    } else {
      bad(cli::ansi_collapse(x))
    },
  )
}

#' @export

print.available_bad_words <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

mark_bad_words <- function(text, marker = NULL) {
  if (is.null(marker)) {
    marker <- cli::combine_ansi_styles(cli::col_white, cli::bg_red)
  }

  vapply(
    tolower(text),
    mark_bad_words1,
    character(1),
    marker = marker,
    USE.NAMES = FALSE
  )
}

mark_bad_words1 <- function(text1, marker) {
  word_pos <- gregexpr("\\b\\w+\\b", text1)
  if (length(word_pos[[1]]) == 1 && word_pos == -1) {
    return(text1)
  }
  start <- c(word_pos[[1]])
  end <- start + attr(word_pos[[1]], "match.length") - 1
  words <- substring(text1, start, end)
  stemmed <- SnowballC::wordStem(words, language = "english")

  bad <- words %in% bad_words() | stemmed %in% bad_words()
  regmatches(text1, word_pos) <- list(ifelse(
    bad, marker(words), words
  ))
  text1
}
