#' Get sentiment of name
#'
#' @param name Name of package to search

sents = tidytext::get_sentiments("bing") 

get_sentiment <- function(name) {
    name_sentiment = sents[sents$word == name, "sentiment"]

    if (nrow(name_sentiment) > 0) {
      return(name_sentiment[[1]])
    } else {
      return(NULL)
    }
}
    
    

