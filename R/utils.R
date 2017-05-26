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

fix_windows_nl <- function(x) {
  gsub("\r\n", "\n", x)
}
