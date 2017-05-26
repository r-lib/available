"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

yes_no <- function(x) {
  if (isTRUE(x)) {
    crayon::green(clisymbols::symbols$tick)
  } else {
    crayon::red(clisymbols::symbols$cross)
  }
}
