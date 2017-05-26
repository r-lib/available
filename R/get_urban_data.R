#' get urban dictionary definitions and tags
#'
#' @param name Name of package to search
get_urban_data<- function(name) {
  term <- tryCatch(as.data.frame(udapi::get_term(name)),
                   error = function(e) e)
  tags <- tryCatch(udapi::get_tags(name)$tags, error = function(e) e)
  structure(list(term, tags), class = "available_urban")
}

print.available_urban <- function(x, ...) {
  cat(crayon::bold("Urban Dictionary:\n"))

  if (inherits(x[[1]], "error")) {
    cat("  Not found.\n")
    return(invisible(x))
  }

  ## Format first definition
  first <- fix_windows_nl(x[[1]]$definition[[1]])
  first <- strwrap(first, indent = 2, exdent = 2)
  first <- mark_bad_words(first)
  cat(first, sep = "\n")

  ## Tags:
  if (! inherits(x[[2]], "error")) {
    tags <- paste(x[[2]], collapse = " ")
    tags <- strwrap(tags, exdent = 2, simplify = TRUE)
    cat("\n  Tags: ", mark_bad_words(tags), sep = "")
    cat("\n")
  }

  ## Link
  cat("\n  ", crayon::blue(x[[1]]$permalink[1]), sep = "")
  cat("\n")

  invisible(x)
}
