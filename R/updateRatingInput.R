#' Change the value of a rating widget on the client
#'
#' @param session The session object passed to function given to shinyServer. Default is getDefaultReactiveDomain().
#' @param inputId The id of the widget.
#' @param value The new value to assign to the widget.
#' @import shiny
#' @return A widget with an updated value.
#' @export

updateRatingInput <- function(session,
                              inputId,
                              value = NA) {
  session$sendInputMessage(inputId, list(value = value))
}
