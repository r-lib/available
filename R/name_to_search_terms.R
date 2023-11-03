# Function that takes a name and generates search terms based on it
name_to_search_terms <- function(name) {
  if (name == toupper(name)) {
    return(name)
  }
  # generate test strings by splitting on & removing periods & digits
  output <- strsplit(x = name, split = "[[:digit:][:punct:]]")

  # generate test strings by splitting on and removing uppercase letters
  removedUppers <- strsplit(x = output[[1]], split = "[[:upper:]]")
  # split on but do not remove uppercase characters
  # assume uppercase first letter in word
  uppersFirst <- strsplit(gsub("([[:upper:]])", " \\1", output[[1]]), split = " ")
  # assume uppercase last letter in word (it happens!)
  uppersLast <- strsplit(gsub("([[:upper:]])", "\\1 ", output[[1]]), split = " ")

  # combine list of search terms generated based on different assumptions about use of capitals
  search_terms <- unique(unlist(c(uppersFirst, uppersLast, removedUppers)))

  # generate test strings by splitting on/removing r
  # searchTermsWithR <- unique(c(searchTerms, unlist(strsplit(x = searchTerms, split = "R"))))

  # remove elements that are just "r", "R" or empty & add name
  search_terms <- c(setdiff(search_terms, c("r", "R", "", name)), name)

  # remove trailing r that is not preceded by a vowel
  search_terms <- sub("(?<![aeiou])[Rr]$", "", search_terms, perl = TRUE)

  unique(search_terms)
}
