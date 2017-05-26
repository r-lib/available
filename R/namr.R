# Function to generate possible package names take in a package title and
# generate possible R-like package names

# examples:
# Soil Physical Analysis -> soilphysics
# JAR Files of the Apache Commons Mathematics Library -> commonsMath
# Tools for Distance Metrics -> distances

# rules:
# if any word starts with "vis", add "vis" to the end of the package name
# if any word starts wiht "viz", add "viz" to the end of the package name
# if any word starts with "plot", add "plot" to the end of the package name
# if any word starts with "tidy", add "tidy" to the beginning of the package name
# if selected word ends in vowel+r, remove vowel beamer -> beamr
# select words at least six characters long
# prioritize words near the edges

pick_word_from_title <- function(title, remove_punct = F){
  # to lower case
  title <- tolower(title)

  # convert to vector of words
  word_vector <- unlist(strsplit(title, " "))

  # if, at any point, we get down to just one word, stop & use that one
  # remove English stopwords
  if(length(word_vector) >  1){
    word_vector <- word_vector[!word_vector %in% tidytext::stop_words$word]
    word_vector <- na.omit(word_vector)
  }

  # remove R-specific stopwords, things that are commonly in package titles but
  # aren't helpful for telling you what the package is about
  if(length(word_vector) > 1){
    R_stop_words <- c("library", "libraries", "analysis", "analyses", "class", "classes", "method",
                      "object", "objects", "model", "import", "data", "function", "format", "plug-in",
                      "plugin", "API", "client", "access", "interface", "tool", "compute", "help",
                      "calculate", "calculation", "calculating", "toolbox", "read", "statistics",
                      "statistical", "math", "mathematics", "mathematically", "modeling", "modelling",
                      "numeric", "file", "plot", "plotting", "plots", "wrapper")
    word_vector <- word_vector[!word_vector %in% R_stop_words]
    word_vector <- na.omit(word_vector)
  }

  # remove very short words (< 5 characters)
  if(length(word_vector) > 1){
    word_vector <- word_vector[nchar(word_vector) > 5]
    word_vector <- na.omit(word_vector)
  }

  # remove very long words (> 15 charactesr)
  if(length(word_vector) > 1){
    word_vector <- word_vector[nchar(word_vector) < 15]
    word_vector <- na.omit(word_vector)
  }

  # pick the longest edge word picking the longest one (< 15 characters)
  if(length(word_vector) > 1){
    first <- word_vector[1]
    last <- word_vector[length(word_vector)]
    if(nchar(last) > nchar(first)){
      package_name <- last
    }else{
      package_name <- first
    }
  }

  # make sure we always return a package name
  if(length(word_vector) == 1){
    package_name <- word_vector[1]
  }

  # remove punctuation if asked for by user
  if(remove_punct){
    package_name <- gsub("[[:punct:]]", "", package_name)
  }

  # return out single word
  return(package_name)
}

# # test: should return "intro.js" & "introjs"
# pick_word_from_title(title = "wrapper for the intro.js library")
# pick_word_from_title("wrapper for the intro.js library", remove_punct = T)


#### spelling transformations to make package names more r-like ####

# remove second to last letter if it's a vowel and the last letter is r

# if the word ends with an r but there isn't a vowel in front of it, add an r to the beginning

# if the first letter is a vowel and the second letter is an r, remove the first letter

# if there isn't one already, add an "r" to the end

# add "plot", "viz" or "vis" to the package name if that appears in the title
grepl("viz*",title, ignore.case = T)
grepl("vis*",title, ignore.case = T)
grepl("plot*",title, ignore.case = T)

