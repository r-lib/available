#' Find five closest package names in terms of string distance
#'
#' @param name name of package
#' @param pkgs packages to compare with
#' @importFrom stringdist stringdist
#'
pkg_name_dist <- function(name, pkgs) {
  distances <- stringdist::stringdist(name, pkgs)

  tibble::tibble(
    pkgs = head(pkgs[order(distances)]),
    distance = head(distances[order(distances)])
  )

}
