

tribe_names <- memoise::memoise(function() {
  url <- "https://www.bia.gov/tribal-leaders-csv"

stop_words_in_tribe_names <-
  tolower(
    c("Tribe of Old Harbor",
    "Village",
    "River Band",
    "Mills",
    "Creek",
    "Lagoon",
    "Pine",
    "Sandy",
    "Valley",
    "Lake",
    "Grande",
    "Nation of New York",
    "Heights",
    "Bay",
    "Springs",
    "Grand",
    "Tribe",
    "Nation",
    "Eastern",
    "Fort",
    "of Texas",
    "of Kansas",
    "of Oklahoma",
    "King",
    "Little",
    "Lower",
    "Indian Nation",
    "Indian Tribe",
    "Point",
    "IRA",
    "Northern",
    "Northwestern",
    "of Utah",
    "Indian Township",
    "Pleasant Point",
    "Bay",
    "of Nebraska",
    "Prairie",
    "Pueblo of",
    "Chapter",
    "Nation of Missouri in Kansas and Nebraska",
    "Oklahoma",
    "United",
    "Pass",
    "Big",
    "Bad",
    "Arctic",
    "Crow",
    "Cow",
    "Dry",
    "Elk",
    "Iowa",
    "River",
    "Hope",
    "Pilot",
    "Ruby",
    "Ottawa",
    "Band",
    "Pyramid",
    "Skull",
    "Upper",
    "Harbor",
    "Inc",
    "of Mississippi",
    "Mountain",
    "Turtle",
    "South",
    "Southern",
    "Red",
    "Round" ,
    "Salt" ,
    "Bear",
    "Berry",
    "Beaver",
    "Augustine",
    "California",
    "Blue" ,
    "Bishop",
    "Cold",
    "Craig" ,
    "Forest",
    "County",
    "Lime",
    "Lone",
    "Mesa",
     "Miami" ,
    "Leech",
    "Minnesota",
    "Barrow",
    "Eagle",
    "False" ,
    "Lay" ,
    "New",
    "Omaha",
    "Wisconsin",
    "Dot",
    "Enterprise" ,
    "Summit",
    "Table",
    "Spirit",
    "Three",
    "Affiliated",
    "White",
    "Devil",
    "Crooked" ,
    "Stony",
    "Twin",
    "Hills",
    "Island",
    "Jackson",
    "Salmon" ,
    "Absentee",
    "Citizen",
    "Island",
     "Manchester",
    "Earth",
    "Mississippi",
    "Council",
    "Walker",
    "Quartz",
    "Platinum",
    "Pit",
    "Station",
    "Petersburg",
    "Wales",
    "Traverse",
    "Slope",
    "Confederated",
    "Circle",
    "Indians Division",
    "Indian Colony",
    "and Sioux",
    "Chicken",
    "Ranch",
    "Federated Indians of",
    "Mission",
    "Port",
    "Cliff",
    "wood",
    "Nelson",
    "Independence" ,
    "Colorado",
    "Lions",
    "ding",
     "Boise" ,
    "age",
    "rampart",
    "-",
    "\\.",
    "'",
    "&",
    "\\(",
    "\\)",
    " "))

  # get list and convert to lower case
  words <- tolower(read.csv(url)[,2])
  # remove stop words
  words <- gsub(paste0(stop_words_in_tribe_names, collapse = "|"), "", words)
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
    crayon::bold("Indigenous tribe names (recommend to not to use): "),
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

mark_tribe_names <- function(text, marker = NULL) {

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

  tribe <- words %in% tribe_names() | stemmed %in% tribe_names()
  regmatches(text1, word_pos) <- list(ifelse(
    tribe, marker(words), words
  ))
  text1
}
