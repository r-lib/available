#' See if a name is available on CRAN
#'
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
#' @export
available_on_cran <- function(name, ...) {
  cran_names <- rownames(available_packages(...))
  archived_names <- names(archive_packages())

  on_cran <- tolower(name) == tolower(cran_names)

  on_cran_archive <- tolower(name) == tolower(archive_names)

  # TODO use adist to return close names
  structure(!on_cran && !on_cran_archive, class = "available_cran")
}

archive_packages <- memoise::memoise(function() {
  ("tools" %:::% "CRAN_archive_db")()
})

available_packages <- memoise::memoise(available.packages)

print.available_cran <- function(x) {
  cat("CRAN:", yes_no(x[[1]]))
}
