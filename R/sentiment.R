get_sentiment <- function(name) {
    sents = tidytext::get_sentiments("bing") 
    name_sentiment = sents[sents$word == name, "sentiment"]

    if (nrow(name_sentiment) > 0) {
      message(sprintf("`%s` has a  `%s` sentiment", name, unlist(name_sentiment)))
    }
}
    
    

