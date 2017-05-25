"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}

yes_no <- function(x) {
  if (isTRUE(x)) {
    crayon::green("\u2713")
  } else {
    crayon::red("X")
  }
}
