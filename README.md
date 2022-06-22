
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyRating

<!-- badges: start -->
<!-- badges: end -->

Easy creation of rating input controls in Shiny.

## Features

-   Compatible with bslib and optimized for Bootstrap 5
-   Compatible with server validation of inputs based on shinyvalidate
-   Large choices of icons from Fontawesome and Glyphicon
-   Easy definition of icon colors (Bootstrap 5 or Hex colors)
-   Possibility to add Bootstrap 5 colored Tooltips to icons
-   Large choice of animations for icons when clicked from animate.css
-   Possibility to define complex rules of icons coloration

## Installation

You can install the development version of ShinyRating from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mhanf/ShinyRating")
```

## Example

ShinyRating exports two main functions: `ratingInput()` and
`updateRatingInput()`.

An example Shiny app using these functions can be created as follows:

``` r
# libraries
library(shiny)
library(ShinyRating)
# a basic card function 
card <- function(title,body){
  tags$div(
    class = "card text-center w-25 border-primary",
    tags$div(class = "card-header bg-primary ",
             title,class = "m-0"),
    tags$div(
      class = "card-body",
      body
    )
  )
}
# ui part
ui <- function(){
  fluidPage(
    theme = bslib::bs_theme(version = 5,bootswatch = "flatly"),
    br(),
    br(),
    card(title = "Survey",
         body = tagList(
           br(),
           ratingInput(
             inputId = "Mood",
             label = "How do you feel ?",
             size = 2,
             on_color = "info",
             off_color = "light",
             i_name = c("angry","frown","meh","smile","laugh"),
             i_lib = "font-awesome",
             anim = "pulse",
             duration = 1,
             number = 5,
             cumul = FALSE,
             tlp = TRUE,
             tlp_color = "info",
             tlp_position = "bottom",
             tlp_msg = c("Angry","Frown","Neutral","Happy","Excited")
           ),
           br(),
           ratingInput("star",
                       label = "Do you think shinyRating is a fun package ?",
                       size = 2,
                       anim = "tada",
                       i_name = "star",
                       on_color = "#D5AB55",
                       cumul = TRUE
           ),
           actionButton("go","Reset",class="btn-success m-1 w-50")
         )
    )
  )
}
# Server part
server <- function(input, output, session) {
  
  observeEvent( 
    input$go , {
      updateRatingInput(session, "star")
      updateRatingInput(session, "Mood")
    }
  )
}
# launch the app
shinyApp(ui = ui, server = server)
```

You can run a gallery and consult vignettes with :

**Work in progress**

## Prior art & philosophy

**Work in progress**

## Contributions

**Work in progress**

## License

**Work in progress**
