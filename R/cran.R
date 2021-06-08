#' See if a name is available on CRAN
#'
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
#' @inheritParams utils::available.packages
#'
#' @examples
#' available_on_cran("semaforos")
#'
#' # Test if this name is available in a non-default CRAN repository
#' available_on_cran("semaforos", repos = "https://bisaloo.r-universe.dev")
#'
#' @export
available_on_cran <- function(name, repos = default_cran_repos, ...) {
  cran_names <- rownames(available_packages(repos = repos, ...))
  archive_names <- names(archive_packages())

  on_cran <- tolower(name) %in% tolower(cran_names)

  on_cran_archive <- tolower(name) %in% tolower(archive_names)

  # TODO use adist to return close names
  structure(!on_cran && !on_cran_archive, class = "available_cran")
}

archive_packages <- memoise::memoise(function() {
  ("tools" %:::% "CRAN_archive_db")()
})

available_packages <- memoise::memoise(available.packages)

#' @export

format.available_cran <- function(x, ...) {
  cat(crayon::bold("Available on CRAN:"), yes_no(x[[1]]), "\n")
}

#' @export

print.available_cran <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

default_cran_repos <-c(
  CRAN = "https://cloud.r-project.org",
  CRANextra = "http://www.stats.ox.ac.uk/pub/RWin")
