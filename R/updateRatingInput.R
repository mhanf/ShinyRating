#' Change the value of a rating input on the client
#'
#' @param session The session object passed to function given to shinyServer. Default is getDefaultReactiveDomain().
#' @param inputId The id of the input.
#' @param value The new value to assign to the input.
#' @return A input with an updated value.
#' @export
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(bslib)
#' library(ShinyRating)
#'
#' ui <- fluidPage(
#' theme = bslib::bs_theme(version = 5, bootwatch = "flatly"),
#' ratingInput(
#'   inputId = "id1",
#'   i_name = "star",
#'   i_on_color = "danger"
#'   ),
#'   shiny::actionButton("update","Update")
#' )
#' server <- function(input, output, session) {
#' shiny::observeEvent(input$update, {
#' updateRatingInput(session = session, inputId = "id1",value = 4)
#' })
#'
#' }
#' shiny::shinyApp(ui, server)
#' }

updateRatingInput <- function(session,
                              inputId,
                              value = NA) {
  session$sendInputMessage(inputId, list(value = value))
}
