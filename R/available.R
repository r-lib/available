#' See if a name is available
#'
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
#' @importFrom memoise memoise
#' @export
available <- function(name, ...) {
  cran_names <- rownames(available_packages(...))

  same <- tolower(name) == tolower(cran_names)
  if (any(same)) {
    return(
      structure(
        list(
          source = "CRAN",
          available = FALSE,
          close = list(pkg_name_dist(name, cran_names))
        ),
        class = "available_cran"
      )
    )
  }

  archived_names <- names(archive_packages())
  same <- tolower(name) == tolower(archived_names)
  if (any(same)) {
    return(
      structure(
        list(
          source = "CRAN archive",
          available = FALSE,
          close = list(pkg_name_dist(name, archived_names))
        ),
        class = "available_cran_archive"
      )
    )
  }

  message(sprintf("`%s` is available!", name))
  invisible(TRUE)
}

archive_packages <- memoise::memoise(function() {
  ("tools" %:::% "CRAN_archive_db")()
})

available_packages <- memoise::memoise(available.packages)
