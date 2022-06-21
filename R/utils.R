#' Test if a text is a hex color
#'
#' @param x text
#'
#' @return TRUE or FALSE
#' @export
#'
#' @examples
#' isHex("test")
#' isHex("#eb4034")

isHex <- function(x){
  grepl("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", x)
}
