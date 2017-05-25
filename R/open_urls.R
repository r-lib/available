#' Open wikipedia page and abbreviations.com page
#'
#' @param name Name of package to search

get_sentiment <- function(name) {
  structure(c(browseURL(paste0("https://en.wikipedia.org/wiki/", name)),
              browseURL(paste0("http://www.abbreviations.com/", name))),
            class = "urls")
  
}






