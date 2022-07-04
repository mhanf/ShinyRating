library(shiny)
library(bslib)
library(ShinyRating)

theme <- bslib::bs_theme(
  version = 5,
  bootswatch = "flatly"
)

# a basic card function
card_suite <- function(
  title,
  body
){
  div(class = "col",
      tags$div(
        class = "card text-center h-100",
        tags$div(
          class = "card-header primary-text fw-bold",
          title
          ),
        tags$div(
          class = "card-body",
          body
        )
      )
  )
}
