"%:::%" <- function(p, f) {
  get(f, envir = asNamespace(p))
}
