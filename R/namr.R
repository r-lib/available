#' Pick word from title
#'
#' picks a single (hopefully informative) word from the provided title or
#' package description
#'
#' @param title text string to pick word from. Package title or description.
#' @param verb whether you would like to prioritize returning a verb
#' @return a single word from the title
#' @keywords internal
pick_word_from_title <- function(title, verb = FALSE) {
  # to lower case
  title <- tolower(title)

  # convert to vector of words

  word_vector <- unlist(strsplit(title, "[[:space:]]+"))
  if (length(word_vector) == 0) {
    return(character())
  }

  # remove R-specific stopwords, things that are commonly in package titles but
  # aren't helpful for telling you what the package is about
  R_stop_words <- c(
    "libr", "analys", "class", "method",
    "object", "model", "import", "data", "function", "format", "plug-in",
    "plugin", "api", "client", "access", "interfac", "tool", "comput", "help",
    "calcul", "tool", "read", "stat", "math", "numer", "file", "plot",
    "wrap", "read", "writ", "pack", "dist", "algo", "code", "frame", "viz",
    "vis", "auto", "explor", "funct", "esti", "equa", "bayes", "learn"
  )

  # remove English stop words
  english_stop_words <- tidytext::stop_words$word

  word_vector <- word_vector[!word_vector %in% c(english_stop_words)]

  word_vector <- word_vector[!grepl(glue_collapse(R_stop_words, "|"), word_vector)]

  # remove very long words (> 15 characters)
  # remove very short words (< 5 characters)
  word_vector <- word_vector[nchar(word_vector) < 15 | nchar(word_vector) > 5]

  package_name <- character()

  # pick the first verb (if the user has requested a verb) or the longest edge word (< 15 characters)
  if (length(word_vector) > 1) {
    # get the part of speech for every word left in our vector
    POS <- apply(
      as.matrix(word_vector), 1,
      function(x) {
        tidytext::parts_of_speech$pos[tidytext::parts_of_speech$word == x][1]
      }
    )
    first <- word_vector[1]
    last <- word_vector[length(word_vector)]
    if (sum(grepl("Verb", POS)) > 0 && verb) {
      package_name <- word_vector[grepl("Verb", POS)][1]
    } else if (nchar(last) > nchar(first)) {
      package_name <- last
    } else {
      package_name <- first
    }
  }

  # make sure we always return a package name
  if (length(word_vector) == 1) {
    package_name <- word_vector[1]
  }

  # remove punctuation
  package_name <- gsub("[[:punct:]]", "", package_name)

  # make sure
  if (length(package_name) == 0) {
    stop("Sorry, we couldn't make a good name from your tile. Try using more specific words in your description.")
  }

  package_name
}

#' Spelling transformations
#'
#' This function takes in a single word and applies spelling transformations to
#' make it more "r-like" and easier to Google
#'
#' @param word a single word to make more rlike
#' @return a single word with a spelling transformation
#' @keywords internal
make_spelling_rlike <- function(word) {
  # convert string into vector of lowercase characters
  chars <- unlist(strsplit(tolower(word), ""))

  # list of vowels
  vowels <- c("a", "e", "i", "o", "u")

  # set a variable that tells us whether we've made a spelling transformation
  spelling_changed <- FALSE

  # remove second to last letter if it's a vowel and the last letter is r
  if (chars[length(chars) - 1] %in% vowels & chars[length(chars)] == "r") {
    chars <- chars[-(length(chars) - 1)]
    spelling_changed <- TRUE
  }

  # if the first letter is a vowel and the second letter is an r, remove the first letter
  if (chars[1] %in% vowels & chars[2] == "r" & spelling_changed == FALSE) {
    chars <- chars[-1]
    spelling_changed <- TRUE
  }

  # if the word ends with an r but there isn't a vowel in front of it, add an r to the beginning
  if (chars[length(chars) - 1] %in% vowels == FALSE & chars[length(chars)] == "r" & spelling_changed == FALSE) {
    chars <- c("r", chars)
    spelling_changed <- TRUE
  }

  # if there hasn't been a spelling change, add an "r" to the end
  if (spelling_changed == FALSE) {
    chars <- c(chars, "r")
  }

  glue_collapse(unlist(chars))
}

#' function to add common, informative suffixes
#'
#' Search a title for common terms (plot, vis..., viz..., markdown) and apply
#' appropriate affixes to a given word as applicable.
#'
#' @param title the package title or description
#' @param name the single word that will be appended to
#'
#' @return a single word with affix, if applicable
#' @keywords internal
common_suffixes <- function(title, name) {
  # add "plot", "viz" or "vis" to the end of the package name if that appears in the title
  if (grepl("\\<tidy", title, ignore.case = TRUE)) {
    return(glue_collapse(c("tidy", name)))
  }
  if (grepl("\\<viz", title, ignore.case = TRUE)) {
    return(glue_collapse(c(name, "viz")))
  }
  if (grepl("\\<vis", title, ignore.case = TRUE)) {
    return(glue_collapse(c(name, "vis")))
  }
  if (grepl("\\<plot", title, ignore.case = TRUE)) {
    return(glue_collapse(c(name, "plot")))
  }
  if (grepl("\\<markdown", title, ignore.case = TRUE)) {
    return(glue_collapse(c(name, "down")))
  }
  name
}

#' Function that finds and returns the first acronym (all caps) in a text string
#'
#' @param title package title or description
#'
#' @return a single acronym, if present
#' @keywords internal
find_acronym <- function(title) {
  # split string
  title_vector <- unlist(strsplit(title, " "))

  # return all
  acronyms <- title_vector[grep("^[[:upper:]]{2,}$", title_vector)]

  # check to make sure it's not already the title
  word <- pick_word_from_title(title)

  # make sure we don't have a name with reduplication
  if (word %in% tolower(acronyms)) {
    stop("Title is already acronym.")
  }

  # return the first acronym from the title
  acronyms[1]
}

#' Suggest package name
#'
#' Suggests a package name based on the package title or description.
#'
#' @param title the package title or description
#' @param acronym whether to include an acronym (if there is one) in the title
#' @param verb whether to prioritize using a verb in the package title
#' @return a single word to use as a package title
#' @keywords internal
namr <- function(title, acronym = FALSE, verb = FALSE, ...) {
  name <- pick_word_from_title(title, verb = verb, ...)
  name <- make_spelling_rlike(name)
  if (acronym) {
    name <- glue_collapse(c(name, find_acronym(title)))
  }
  name <- common_suffixes(title, name)
  name
}
