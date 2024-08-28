#' See if a name is available on github
#'
#' @param name Name of package to search
#' @importFrom jsonlite fromJSON
#' @export
available_on_github <- function(name) {
  github_names <- gh_pkg(name)
  my_links <- github_link_location()
  github_names <- github_names[!github_names[["pkg_location"]] %in% my_links, ]

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
      close = list()
    ),
    class = "available_github"
  )
}

gh_pkg <- memoise::memoise(function(pkg) {
  res <- jsonlite::fromJSON(paste0("http://rpkg-api.gepuro.net/rpkg?q=", pkg))
  if (length(res) == 0) {
    return(data.frame(pkg_name = character(), pkg_location = character(), pkg_org = character()))
  }
  res$pkg_location <- res$pkg_name
  res$pkg_org <- vapply(strsplit(res$pkg_location, "/"), `[[`, character(1), 1)
  res$pkg_name <- vapply(strsplit(res$pkg_location, "/"), `[[`, character(1), 2)
  res[!(res$pkg_org == "cran" | res$pkg_org == "Bioconductor-mirror"), ]
})

#' @export

format.available_github <- function(x, ...) {
  paste0(cli::style_bold("Available on GitHub: ", yes_no(x[[1]]), "\n"))
}

#' @export

print.available_github <- function(x, ...) {
  cat(format(x, ...))
  invisible(x)
}

github_link_location <- function() {
  tryCatch(
    {
      desc <- desc::desc()
      urls <- desc$get_urls()
      gh_links <- grep("^https?://github.com/", urls, value = TRUE)

      gsub("https?://github.com/(.*)/?$", "\\1", gh_links)
    },
    error = function(e) character(0)
  )
}
