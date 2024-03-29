% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/updateRatingInput.R
\name{updateRatingInput}
\alias{updateRatingInput}
\title{Change the value of a rating input on the client}
\usage{
updateRatingInput(session, inputId, value = NA)
}
\arguments{
\item{session}{The session object passed to function given to shinyServer. Default is getDefaultReactiveDomain().}

\item{inputId}{The id of the input.}

\item{value}{The new value to assign to the input.}
}
\value{
A input with an updated value.
}
\description{
Change the value of a rating input on the client
}
\examples{
if (interactive()) {
  library(shiny)
  library(bslib)
  library(ShinyRating)

  ui <- fluidPage(
    theme = bslib::bs_theme(version = 5, bootwatch = "flatly"),
    ratingInput(
      inputId = "id1",
      i_name = "star",
      i_on_color = "danger"
    ),
    shiny::actionButton("update", "Update")
  )
  server <- function(input, output, session) {
    shiny::observeEvent(input$update, {
      updateRatingInput(session = session, inputId = "id1", value = 4)
    })
  }
  shiny::shinyApp(ui, server)
}

}
