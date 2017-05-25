#' See if a name is available on github
#'
#' @param name Name of package to search
#' @importFrom jsonlite fromJSON
#' @export
available_github <- function(name) {
  github_names <- github_packages()

  same <- tolower(name) == tolower(github_names)
  if (any(same)) {
    return(
      structure(
        list(
          source = "github",
          available = FALSE,
          close = list(pkg_name_dist(name, github_names))
        ),
        class = "available_github"
      )
    )
  }

  message(sprintf("`%s` is available!", name))
  invisible(TRUE)
}

github_packages <- memoise::memoise(function() {
  # url of github R packages JSON
  github_db_url <- "http://rpkg.gepuro.net/download"

  # parse JSON into R
  github_db <- jsonlite::read_json(github_db_url)[[1]]

  # parse package names from JSON
  github_names <- vapply(github_db, function(x) {
    x[["pkg_name"]]
  }, character(1))

  # remove github username
  stringr::str_extract(github_names, "([^/]+$)")

})
