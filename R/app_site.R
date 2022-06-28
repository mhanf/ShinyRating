#' Shiny app that demonstrates capabilities of ShinyRating package
#'
#' @import shiny
#' @import bslib
#'
#' @export
#' @return a shiny app demonstrating Interfacer capabilities

app_gallery<-function(){
  # global
  theme <- bslib::bs_theme(
    version = 5,
    bootswatch = "flatly"
  )

  # a basic card function
  card_suite <- function(title,body){
    div(class = "col",
        tags$div(
          class = "card text-center h-100",
          tags$div(class = "card-header primary-text fw-bold",
                   title),
          tags$div(
            class = "card-body",
            body
          )
        ))
  }
  # ui
  ui <- shiny::navbarPage(
    "ShinyRating",
    theme = theme,
    tabPanel(
      "Gallery",
      div(class="mb-4",
      div(class="row row-cols-1 row-cols-md-2 g-4",
          # intro
          card_suite(title = "Widget Initial value",
                     body = tagList(
                       p("An initial value can be specified to the widget with the 'value' parameter of ratingInput()"),
                       div(class = "row",
                           div(class="col-md-6", ratingInput("intro1", label = "value = NA")),
                           div(class="col-md-6", ratingInput("intro2", label = "value = 3",value = 3))
                       )
                     )
          ),
          # intro
          card_suite(title = "Update widget value",
                     body = tagList(
                       p("widget value can be update from the server with the 'value' parameter of updateRatingInput()"),
                       div(class = "row",
                           div(class="col-md-6",
                               ratingInput("intro3", label = "value = NA", value = 5),
                               actionButton("update1","Reset", class="btn-primary")
                           ),
                           div(class="col-md-6",
                               ratingInput("intro4", label = "value = 3"),
                               actionButton("update2","Update", class="btn-primary")
                           ),
                       )
                     )
          )
          )),
      div(
        class="row row-cols-1 row-cols-md-3 g-4",
          # basics
          card_suite(title = "Basics",
                     body = tagList(
                       p("To parameter your widgets, you can also specify the off and on colors of icons. Colors can be specified as Boostrap 5 names or Hex code"),
                       ratingInput("basic1", label = "number = 7", number = 7),
                       ratingInput("basic2", label = "size = 3", size = 3),
                       ratingInput("basic3", label = "i_name = 'heart'", i_name = 'heart'),
                       ratingInput("basic4", label = "i_name = 'film', i_lib = 'glyphicon'", i_name = 'film', i_lib = 'glyphicon')
                     )
          ),
          # colors
          card_suite(title = "Colors",
                     body = tagList(
                       p("To parameter your widgets, you can easily specify the number, size, and type of icons. Available icons are those from shiny icon() function."),
                       ratingInput("color1", label = "on_color = 'danger'", on_color = 'danger'),
                       ratingInput("color2", label = "off_color = 'light'", off_color = 'light'),
                       ratingInput("color3", label = "on_color = '#D5AB55'", on_color = '#D5AB55'),
                       ratingInput("color4", label = "off_color = '#add8e6'", off_color = '#add8e6')
                     )
          ),
          # animation
          card_suite(title = "Animations",
                     body = tagList(
                       p("To develop emphasis you can add animations on icons click as well as define their duration.
          Available animations are those from the ", tags$a(href="https://animate.style/", target="_blank", "animate.css"),"website."),
                       ratingInput("anim1", label = "anim = 'jello'", anim = "jello"),
                       ratingInput("anim2", label = "anim = 'flash'", anim = "flash"),
                       ratingInput("anim3", label = "anim = 'swing'", anim = "swing"),
                       ratingInput("anim4", label = "anim = 'jello', duration = 10", anim = "jello", duration = 10)
                     )
          ),
          # tooltips
          card_suite(title = "Tooltips",
                     body = tagList(
                       p("To develop lisibility, you can add tooltips on icons hover with personalized position, color (only bootstrap 5 colors) and label."),
                       ratingInput("tlp1", label = "tlp = TRUE", tlp = TRUE),
                       ratingInput("tlp2", label = "tlp = TRUE, tlp_color = 'danger'",tlp = TRUE, tlp_color = "danger"),
                       ratingInput("tlp3", label = "tlp = TRUE, tlp_position = 'top'",tlp = TRUE, tlp_position = "top"),
                       ratingInput("tlp4", label = "tlp = TRUE, tlp_msg = c('Very bad','Bad','Neutral','Good','Very good')",tlp = TRUE, tlp_msg = c('Very bad','Bad','Neutral','Good','Very good'))
                     ))),
      br(),
      br()
    )
  )
  # serveur
  server <- function(input, output,session) {

    observeEvent(
      input$update1 , {
        updateRatingInput(session, "intro3")
      }
    )

    observeEvent(
      input$update2 , {
        updateRatingInput(session, "intro4", value = 3)
      }
    )

  }
  # launch shiny app
  shiny::shinyApp(ui = ui, server = server)
}
