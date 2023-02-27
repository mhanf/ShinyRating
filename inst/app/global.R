library(shiny)
library(bslib)
library(ShinyRating)
library(shinyvalidate)

# theme <- bslib::bs_theme(
#   version = 5,
#   bootswatch = "flatly"
# )

# a basic card function
card_suite <- function(
    title,
    body
    ) {
  div(
    class = "col h-100",
    tags$div(
      class = "card text-center ",
      tags$div(
        class = "card-header bg-primary fw-bold",
        title
      ),
      tags$div(
        class = "card-body",
        body
      )
    )
  )
}


# rating input with col

ratingInput2 <- function(col_size = 4,...){
  div(class = sprintf("col-md-%s", col_size),
      ratingInput(...)
  )
}

actionButton2 <- function(col_size = 4,...){
  div(class = sprintf("col-md-%s", col_size),
      actionButton(...)
  )
}
