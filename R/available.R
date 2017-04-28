#' See if a name is available
#'
#' @param name Name of package to search
#' @param ... Additional arguments passed to [utils::available.packages()].
available <- function(name, ...) {
  cran_names <- rownames(available_packages(...))

  same <- tolower(name) == tolower(cran_names)
  if (any(same)) {
    stop(sprintf("`%s` conflicts with %s", name, paste0("`", cran_names[same], "`", collapse = ", ")), call. = FALSE)
  }

  archived_names <- names(archive_packages())
  same <- tolower(name) == tolower(archived_names)
  if (any(same)) {
    stop(sprintf("`%s` conflicts with %s", name, paste0("`", archived_names[same], "`", collapse = ", ")), call. = FALSE)
  }

  message(sprintf("`%s` is available!", name))
  invisible(TRUE)
}

archive_packages <- memoise::memoise(function() {
  ("tools" %:::% "CRAN_archive_db")()
})

available_packages <- memoise::memoise(available.packages)
