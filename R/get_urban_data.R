#' get urban dictionary definitions and tags
#'
#' @param name Name of package to search

get_urban_data<- function(name) {
  defs <- safely(head)(udapi::get_term(name)$definition)
  tags <- safely(head)(udapi::get_tags(name)$tags)
  
  structure(list(defs$result, tags$result), class = "urban")
}

