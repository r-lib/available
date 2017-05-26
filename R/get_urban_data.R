#' get urban dictionary definitions and tags
#'
#' @param name Name of package to search
get_urban_data<- function(name) {
  term <- tryCatch(as.data.frame(udapi::get_term(name)),
                   error = function(e) e)
  tags <- tryCatch(udapi::get_tags(name)$tags, error = function(e) e)
  structure(list(term, tags), class = "available_urban")
}

#' @export

format.available_urban <- function(x, ...) {
  res <- character()
  out <- function(...) res <<- c(res, paste(...))

  out(crayon::bold("Urban Dictionary:\n"))

  if (inherits(x[[1]], "error")) {
    out("  Not found.\n")
    return(paste(res, collapse = ""))
  }

  ## Format first definition
  first <- fix_windows_nl(x[[1]]$definition[[1]])
  first <- strwrap(first, indent = 2, exdent = 2)
  first <- mark_bad_words(first)
  out(first, sep = "\n")

  ## Tags:
  if (! inherits(x[[2]], "error")) {
    tags <- paste(x[[2]], collapse = " ")
    tags <- strwrap(tags, exdent = 2, simplify = TRUE)
    out("\n  Tags: ", mark_bad_words(tags), sep = "")
    out("\n")
  }

  ## Link
  out("\n  ", crayon::blue(x[[1]]$permalink[1]), sep = "")
  out("\n")

  paste(res, collapse = "")
}

#' @export

print.available_urban <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}
