#' See if a name is available on github
#'
#' @param name Name of package to search
#' @importFrom jsonlite fromJSON
#' @export
available_on_github <- function(name) {
  github_names <- github_packages()

  same <- tolower(name) == tolower(github_names[["pkg_name"]])
  if (any(same)) {
    return(
      structure(
        list(
          available = FALSE,
          close = list(pkg_name_dist(name, github_names))
        ),
        class = "available_github"
      )
    )
  }
  structure(
    list(
      available = TRUE,
      close = list()),
    class = "available_github")
}

github_packages <- memoise::memoise(function() {
  # url of github R packages JSON
  github_db_url <- "http://rpkg.gepuro.net/download"

  # parse JSON into R
  github_db <- jsonlite::read_json(github_db_url)[[1]]

  # parse package names from JSON
  github_names <- dplyr::bind_rows(github_db)

  # remove github username
  github_names[["pkg_name"]] <- stringr::str_extract(github_names[["pkg_name"]], "([^/]+$)")

  github_names

})

print.available_github <- function(x) {
  cat(crayon::bold("Available on GitHub:", yes_no(x[[1]]), "\n"))
}
