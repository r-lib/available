"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

yes_no <- function(x) {
  if (isTRUE(x)) {
    crayon::green(clisymbols::tick)
  } else {
    crayon::red(clisymbols::cross)
  }
}
