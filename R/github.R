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
  tryCatch({
    rpkg_res <- jsonlite::fromJSON(paste0("http://rpkg-api.gepuro.net/rpkg?q=", pkg))
    if (length(rpkg_res) == 0) {
      return(data.frame(pkg_name = character(), pkg_location = character(), pkg_org = character()))
    }
    rpkg_res$pkg_location <- rpkg_res$pkg_name
    rpkg_res$pkg_org <- vapply(strsplit(rpkg_res$pkg_location, "/"), `[[`, character(1), 1)
    rpkg_res$pkg_name <- vapply(strsplit(rpkg_res$pkg_location, "/"), `[[`, character(1), 2)
    rpkg_res[!(rpkg_res$pkg_org == "cran" | rpkg_res$pkg_org == "Bioconductor-mirror"), ]
  },
  error = function(cond){
    message("Got an error trying to use rpkg-api, trying GitHub's api")
    message("Here's the original error message:")
    message(paste0(cond, "\n"))

    gh_api_res <- jsonlite::fromJSON(paste0("https://api.github.com/search/repositories?q=",
                                            pkg,"+language:R&sort=stars&order=desc"))$items

    if (length(gh_api_res) == 0) {
      return(data.frame(pkg_name = character(), pkg_location = character(), pkg_org = character()))
    }

    gh_res <- data.frame(pkg_location = gh_api_res$full_name)
    gh_res$pkg_org <- vapply(strsplit(gh_res$pkg_location, "/"), `[[`, character(1), 1)
    gh_res$pkg_name <- vapply(strsplit(gh_res$pkg_location, "/"), `[[`, character(1), 2)
    gh_res[!(gh_res$pkg_org == "cran" | gh_res$pkg_org == "Bioconductor-mirror"), ]


  })
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
