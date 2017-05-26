#' See if a name is available on github
#'
#' @param name Name of package to search
#' @importFrom jsonlite fromJSON
#' @export
available_on_github <- function(name) {
  github_names <- gh_pkgs()

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


gh_pkgs <- memoise::memoise(function() {
  res <- jsonlite::fromJSON("http://rpkg.gepuro.net/download")
  res <- res$pkg_list
  res$pkg_location <- res$pkg_name
  res$pkg_org <- vapply(strsplit(res$pkg_location, "/"), `[[`, character(1), 1)
  res$pkg_name <- vapply(strsplit(res$pkg_location, "/"), `[[`, character(1), 2)
  res[!(res$pkg_org == "cran" | res$pkg_org == "Bioconductor-mirror" | res$pkg_name %in% available_packages()[, "Package"]), ]
})

print.available_github <- function(x) {
  cat(crayon::bold("Available on GitHub:", yes_no(x[[1]]), "\n"))
}
