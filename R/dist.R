#' Find five closest package names in terms of string distance
#'
#' @param name name of package
#' @param pkgs packages to compare with
#' @importFrom stringdist stringdist
#' @importFrom utils head
#'
pkg_name_dist <- function(name, pkgs) {
  distances <- stringdist::stringdist(name, pkgs)

  tibble::tibble(
    pkgs = utils::head(pkgs[order(distances)]),
    distance = utils::head(distances[order(distances)])
  )

}
