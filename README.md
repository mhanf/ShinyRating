
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyRating

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/interfacer)](https://CRAN.R-project.org/package=interfacer)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)
<!-- badges: end -->

Easy creation of rating input controls in Shiny.

## Features

-   Compatible with bslib and optimized for Bootstrap 5
-   Compatible with server validation of inputs based on shinyvalidate
-   Large choices of icons from Fontawesome and Glyphicon
-   Easy definition of icon size and colors (Bootstrap 5 or Hex colors)
-   Possibility to add Bootstrap 5 colored Tooltips to icons
-   Read only mode for rating input
-   Hover capabilities for rating input
-   Large choice of animations for icons when clicked from animate.css
-   Possibility to define complex rules of icons coloration, size,
    animation and read only mode

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

A Shiny app example using these functions can be created as follows:

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
                 #read_only = c(TRUE, TRUE, TRUE, FALSE, FALSE),
                 #value = 3,
                 size = 3,
                 on_color = c("danger","warning","dark","info","success"),
                 off_color = "light",
                 i_name = c("angry","frown","meh","smile","laugh"),
                 i_lib = "font-awesome",
                 anim = "pulse",
                 duration = 1,
                 number = 5,
                 cumul = FALSE,
                 tlp = TRUE,
                 tlp_color = c("danger","warning","dark","info","success"),
                 tlp_position = "bottom",
                 tlp_msg = c("Angry","Frown","Neutral","Happy","Excited"),
                 hover = TRUE
               ),
               br(),
               ratingInput("star",
                           label = "Where is shinyRating on the fun scale ?",
                           size = 2,
                           anim = "tada",
                           i_name = "star",
                           on_color = "#D5AB55",
                           cumul = TRUE,
                           hover = TRUE
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
      updateRatingInput(session, "Mood", value = 3)
    }
  )
  #observe({print(input$Mood)})
}
# launch the app
shinyApp(ui = ui, server = server)
```

You can run a gallery and consult vignettes with :

**Work in progress**

## Prior art & philosophy

The core functionnalities of this package are similar to those of the
[ShinyRatingInput](https://github.com/stefanwilhelm/ShinyRatingInput).
This package tries to overcome some of its limitations by being
compatible with the shinyverse packages developed by Rstudio (mostly
[shinyvalidate](https://rstudio.github.io/shinyvalidate/) and
[bslib](https://rstudio.github.io/bslib/)) as well as extending its
functionnalities (color, size, animation …). The Tooltip functionnality
is largely inspired from the one of the
[bsutils](https://github.com/JohnCoene/bsutils) package. The idea to use
animate.css comes from the
[shinyanimate](https://github.com/Swechhya/shinyanimate) package.

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
