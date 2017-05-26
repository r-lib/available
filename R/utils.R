"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

yes_no <- function(x) {
  if (isTRUE(x)) {
    crayon::green(clisymbols::symbol$tick)
  } else {
    crayon::red(clisymbols::symbol$cross)
  }
}
