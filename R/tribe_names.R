

tribe_names <- memoise::memoise(function() {
  url <- "https://www.bia.gov/tribal-leaders-csv"

  words <- jsonlite::fromJSON(url)[[1]]
  # remove non-alphanumerics
  words <- gsub("[^[:alnum:]]", "", words)
  # remove blank and short strings
  words <- words[nchar(words) > 2]

  unique(words)
})

#' Check for tribe names in pkg name
#'
#' @inheritParams available
#' @export
#' @seealso See \url{https://www.bia.gov/tribal-leaders-directory}
get_tribe_names  <- function(name) {
  # check each bad word to see if in package name
  tribe <- grepl(glue_collapse(tribe_names(), "|"), name)

  structure(name[tribe], class = "available_tribe_names")
}

#' @export

format.available_tribe_names <- function(x, ...) {
  good <- crayon::green
  bad <- crayon::combine_styles(crayon::bgRed, crayon::white)
  paste0(
    crayon::bold("Tribe names: "),
    if (length(x) == 0) {
      good(clisymbols::symbol$tick)
    } else {
      bad(glue_collapse(x, sep = ", ", last = " and "))
    },
    "\n"
  )
}

#' @export

print.available_tribe_names <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

mark_bad_words <- function(text, marker = NULL) {

  if (is.null(marker)) {
    marker <- crayon::combine_styles(crayon::white, crayon::bgRed)
  }

  vapply(
    tolower(text),
    mark_tribe_names1,
    character(1),
    marker = marker,
    USE.NAMES = FALSE
  )
}

mark_tribe_names1 <- function(text1, marker) {
  word_pos <- gregexpr("\\b\\w+\\b", text1)
  if (length(word_pos[[1]]) == 1 && word_pos == -1) return(text1)
  start <- c(word_pos[[1]])
  end <- start + attr(word_pos[[1]], "match.length") - 1
  words <- substring(text1, start, end)
  stemmed <- SnowballC::wordStem(words, language = "english")

  bad <- words %in% tribe_names() | stemmed %in% tribe_names()
  regmatches(text1, word_pos) <- list(ifelse(
    tribe, marker(words), words
  ))
  text1
}
