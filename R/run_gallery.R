#' Shiny app: shinyRating capabilities
#' @description Shiny app demonstrating the rating widget capabilities.
#'
#' @return No returned value, this function just runs a Shiny app.
#'
#' @importFrom shiny shinyAppDir
#' @export

run_gallery <- function() {
  appDir <- system.file("app", package = "ShinyRating")
  shinyAppDir(appDir)
}
