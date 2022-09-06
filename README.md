
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ShinyRating

<!-- ex : https://metroui.org.ua/rating.html -->
<!-- ex : https://www.wbotelhos.com/raty -->
<!-- https://github.com/Monte9/react-native-ratings -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!--[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)-->
[![R-CMD-check](https://github.com/mhanf/ShinyRating/workflows/R-CMD-check/badge.svg)](https://github.com/mhanf/ShinyRating/actions)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/GPL-3.0)
[![CRAN
status](https://www.r-pkg.org/badges/version/ShinyRating)](https://CRAN.R-project.org/package=ShinyRating)
<!-- badges: end -->

Easy creation of rating inputs in Shiny.

## Features

-   Optimized for [Bootstrap 5](https://getbootstrap.com/).
-   Possibility to use [fontawesome
    6.1.2](https://fontawesome.com/icons) icons as well as user-defined
    SVG images.
-   Simple definition of the number, size (height and width), type,
    margin (left and right), color and animation of icons.
-   Possibility to add tooltips.
-   Read only, hover and accumulation modes.
-   Possibility to define individual setting rules for icons.
-   Compatible with server validation of inputs based on
    [shinyvalidate](https://rstudio.github.io/shinyvalidate) package.

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
        width = 12,
        align = "center",
        br(),
        ratingInput(
          inputId = "mood",
          label = "How do you feel ?",
          number = 5,
          value = NA,
          cumul = FALSE,
          hover = TRUE,
          i_on_color = c("danger","warning","dark","info","success"),
          i_off_color = "light",
          i_name = c("face-angry","face-frown","face-meh","face-smile","face-laugh"),
          i_lib = "fontawesome",
          i_anim = "pulse",
          i_duration = 1,
          tlp = TRUE,
          tlp_color = c("danger","warning","dark","info","success"),
          tlp_position = "bottom",
          i_value = c("Angry","Frown","Neutral","Happy","Excited")
        ),
        br(),
        ratingInput(
          inputId = "star",
          label = "Where is shinyRating on the fun scale ?",
          i_anim = "tada",
          i_width = "2em",
          i_name = "star",
          i_lib = "fontawesome",
          i_on_color = "#D5AB55",
          cumul = TRUE,
          hover = TRUE
        ),
        br(),
        actionButton("go","Reset",class="btn-success m-1"),
        actionButton("update","Update",class="btn-success m-1"),
        br(),
        textOutput("rating1"),
        textOutput("rating2")
      )
    )
  )
}
# Server part
server <- function(input, output, session) {
  observeEvent( 
    input$go , {
      updateRatingInput(session, "star")
      updateRatingInput(session, "mood")
    }
  )
  observeEvent( 
    input$update , {
      updateRatingInput(session, "star",value = 5)
      updateRatingInput(session, "mood", value = "Excited")
    }
  )
  observe({
    output$rating1 <- renderText(paste0("response 1: ",input$mood))
    output$rating2 <- renderText(paste0("response 2: ",input$star))
    })
}
# launch the app
shinyApp(ui = ui, server = server)
```

You can run a gallery with :

``` r
ShinyRating::run_gallery()
```

A live version is available here : <http://>…

## Prior art & philosophy

The core functionnalities of this package are similar to those of the
[ShinyRatingInput](https://github.com/stefanwilhelm/ShinyRatingInput).
This package tries to overcome some limitations by being compatible with
the shinyverse packages developed by Rstudio (mostly
[shinyvalidate](https://rstudio.github.io/shinyvalidate/),
[bslib](https://rstudio.github.io/bslib/) and
[fontawesome](https://github.com/rstudio/fontawesome)) as well as
extending its functionnalities (color, size, animation …). The tooltip
functionality is inspired from the one of the
[bsutils](https://github.com/JohnCoene/bsutils) package. SVG loading
functionnalities are strongly inspired from the ones of
[icons](https://github.com/mitchelloharawild/icons) package.The idea to
use [animate.css](https://animate.style/) comes from the
[shinyanimate](https://github.com/Swechhya/shinyanimate) package.

## Contributions

The developer and maintainer is [mhanf](https://github.com/mhanf).
External contributions are welcome. Please keep in mind that I am not a
professional R developer but an enthusiastic R data scientist who plays
with shiny and javascript as a pretext to learn new stuffs.
Unfortunately, so is my code. Please note that the ShinyRating project
is released with a [Contributor Code of
Conduct](https://mhanf.github.io/ShinyRating/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.

## License

The ShinyRating package as a whole is licensed under the
[MIT](https://opensource.org/licenses/mit-license.php) license.The
animate.css library used in this package is licensed under the
[HL3](https://firstdonoharm.dev/) license.
