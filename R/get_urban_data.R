#' get urban dictionary definitions and tags
#'
#' @param name Name of package to search
get_urban_data<- function(name) {
  term <- tryCatch(udapi::get_term(name), error = function(e) e)
  tags <- tryCatch(udapi::get_tags(name)$tags, error = function(e) e)
  structure(list(as.data.frame(term), tags), class = "available_urban")
}

print.available_urban <- function(x, ...) {
  cat(crayon::bold("Urban Dictionary:\n"))

  ## Format first definition
  first <- fix_windows_nl(x[[1]]$definition[[1]])
  cat(strwrap(first, indent = 2, exdent = 2), sep = "\n")

  ## Link
  cat("\n  ", crayon::blue(x[[1]]$permalink[1]), sep = "")
  cat("\n")

  invisible(x)
}
