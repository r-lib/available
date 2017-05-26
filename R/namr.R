#' @importFrom stats na.omit

# This is a set of functions to generate a package name, given the title of the package

# This function picks a single word from the title

pick_word_from_title <- function(title) {
  # to lower case
  title <- tolower(title)

  # convert to vector of words

  word_vector <- unlist(strsplit(title, "[[:space:]]+"))
  if (length(word_vector) == 0) {
    return(character())
  }

  # remove R-specific stopwords, things that are commonly in package titles but
  # aren't helpful for telling you what the package is about
  R_stop_words <- c("libr", "analys", "class", "method",
    "object", "model", "import", "data", "function", "format", "plug-in",
    "plugin", "API", "client", "access", "interfac", "tool", "comput", "help",
    "calcul", "tool", "read", "stat", "math", "numer", "file", "plot",
    "wrap", "read", "writ", "pack", "dist", "algo", "code", "frame", "viz",
    "vis")

  # remove English stop words
  english_stop_words <- tidytext::stop_words$word

  word_vector <- word_vector[!word_vector %in% c(english_stop_words)]

  word_vector <- word_vector[!grepl(glue::collapse(R_stop_words, "|"), word_vector)]

  # remove very long words (> 15 characters)
  # remove very short words (< 5 characters)
  word_vector <- word_vector[nchar(word_vector) < 15 | nchar(word_vector) > 5]

  package_name <- character()

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

  # remove punctuation
  package_name <- gsub("[[:punct:]]", "", package_name)

  # make sure 
  if(length(package_name) == 0) {
    stop("Sorry, we couldn't make a good name from your tile.")
  }

  package_name
}

# # test: should return "intro.js" & "introjs"
# pick_word_from_title(title = "wrapper for the intro.js library")
# pick_word_from_title("wrapper for the intro.js library", remove_punct = T)


# spelling transformations to make package names more r-like & make it easier to
# google
make_spelling_rlike <- function(word){
  # convert string into vector of lowercase characters
  chars <- unlist(strsplit(tolower(word),""))

  # list of vowels
  vowels <- c("a","e","i","o","u")

  # set a variable that tells us whether we've made a spelling transformation
  spelling_changed <- F

  # remove second to last letter if it's a vowel and the last letter is r
  if(chars[length(chars) -1] %in% vowels & chars[length(chars)] == "r"){
    chars <- chars[-(length(chars) - 1)]
    spelling_changed <- T
  }

  # if the first letter is a vowel and the second letter is an r, remove the first letter
  if(chars[1] %in% vowels & chars[2] == "r" & spelling_changed == F){
    chars <- chars[-1]
    spelling_changed <- T
  }

  # if the word ends with an r but there isn't a vowel in front of it, add an r to the beginning
  if(chars[length(chars) -1] %in% vowels == F & chars[length(chars)] == "r"& spelling_changed == F){
    chars <- c("r", chars)
    spelling_changed <- T
  }

  # if there hasn't been a spelling change, add an "r" to the end
  if(spelling_changed == F){
    chars <- c(chars, "r")
  }

  return(paste(unlist(chars), collapse = ""))
}

# # testing function.
# make_spelling_rlike("tidy") # Should return "tidyr"
# make_spelling_rlike("archive") #should retun rchive
# make_spelling_rlike("reader") # should return readr
# make_spelling_rlike("instr") # should return rinstr


# function to add common, informative suffixes
common_suffixes <- function(title, name){
  # add "plot", "viz" or "vis" to the end of the package name if that appears in the title
  if(grepl("\\<tidy",title, ignore.case = T)){
    return(paste(c("tidy",name), collapse = ""))
  }
  if(grepl("\\<viz",title, ignore.case = T)){
    return(paste(c(name, "viz"), collapse = ""))
  }
  if(grepl("\\<vis",title, ignore.case = T)){
    return(paste(c(name, "vis"), collapse = ""))
  }
  if(grepl("\\<plot",title, ignore.case = T)){
    return(paste(c(name, "plot"), collapse = ""))
  }
  return(name)
}

# #testing fuction
# plot_vis_add_to_name("package for plotting things","my") # should return "myplot"
# plot_vis_add_to_name("vizulier 2000 the reboot","my") # should return "myviz"

# function to (optionally) include the first acronym used in the title
find_acronym <- function(title){
  # split string
  title_vector <- unlist(strsplit(title, " "))

  # return all
  acronyms <- title_vector[grep("^[[:upper:]]{2,}$", title_vector)]

  # check to make sure it's not already the title
  word <- pick_word_from_title(title)

  # make sure we don't have a name with reduplication
  if(word %in% tolower(acronyms)){
    stop("Title is already acronym.")
  }

  # return the first acronym from the title
  return(acronyms[1])
}

# funciton that strings functions together
namr <- function(title, acronym = F){
  name <- pick_word_from_title(title)
  name <- make_spelling_rlike(name)
  if(acronym){
    name <- paste(c(name, find_acronym(title)), collapse = "")
  }
  name <- common_suffixes(title, name)
  return(name)
}

# # some real  test examples
# namr("A Package for Displaying Visual Scenes as They May Appear to an Animal with Lower Acuity")
# namr("Analysis of Ecological Data : Exploratory and Euclidean Methods in Environmental Sciences")
# namr("Population Assignment using Genetic, Non-Genetic or Integrated Data in a Machine Learning Framework")
