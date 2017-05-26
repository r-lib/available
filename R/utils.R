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

fix_windows_nl <- function(x) {
  gsub("\r\n", "\n", x)
}
