
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyRating

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/interfacer)](https://CRAN.R-project.org/package=interfacer)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License:
GPLv3](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)
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

An Shiny app example using these functions can be created as follows:

``` r
# libraries
library(shiny)
library(ShinyRating)
library(bslib)
# a basic card function 
card <- function(title,body){
  tags$div(
    class = "card text-center",
    tags$div(class = "card-header primary-text fw-bold",
             title),
    tags$div(
      class = "card-body",
      body
    )
  )
}
# ui part
ui <- function(){
  fluidPage(
    theme = bslib::bs_theme(
      version = 5,
      bootswatch = "flatly"
    ),
    br(),
    fluidRow(
      column(
        width = 3,
        card(title = "A little Survey",
             body = tagList(
               br(),
               ratingInput(
                 inputId = "Mood",
                 label = "How do you feel ?",
                 size = 2,
                 on_color = "info",
                 off_color = "dark",
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
                           label = "Where is shinyRating on the fun scale ?",
                           size = 2,
                           anim = "tada",
                           i_name = "star",
                           on_color = "#D5AB55",
                           cumul = TRUE
               ),
               br(),
               actionButton("go","Reset",class="btn-success m-1 w-50")
             )
        )
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

The developer and maintainer is [mhanf](https://github.com/mhanf).
External contributions are welcome. Please keep in mind that I am not a
professional R developer but an enthusiastic R data scientist who plays
with shiny and js as a pretext to learn new stuffs. Unfortunately, so is
my code. Please note that the ShinyRating project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## License

The ShinyRating package as a whole is licensed under the MIT license.
