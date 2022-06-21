#' Change the value of a rating input on the client
#'
#' @param session The session object passed to function given to shinyServer. Default is getDefaultReactiveDomain().
#' @param inputId The id of the input object.
#' @param value Initial value.
#' @import shiny
#' @return an updated value of a rating input
#' @export

updateRatingInput <- function(
  session,
  inputId,
  value
){
  session$sendInputMessage(inputId, list(value = value))
}

