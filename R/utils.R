#' Test if a text is a hex color
#'
#' @param x text
#'
#' @return TRUE or FALSE

isHex <- function(x){
  grepl("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", x)
}
