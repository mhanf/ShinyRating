ui <- shiny::navbarPage(
  "ShinyRating",
  theme = theme,
  tabPanel(
    "Gallery",
    # cards
    div(
      class = "row row-cols-1 row-cols-md-3 g-4",
      # basics
      card_suite(
        title = "Basics",
        body = tagList(
          p("To parameter your widgets, you can easily specify the number, size, and type of icons.
            Available icons are those from shiny icon() function."),
          # size
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("basic1", label = "number = 3", number = 3)
            ),
            div(
              class="col-md-6",
              ratingInput("basic2", label = "number = 5", number = 5)
            )
          ),
          # size
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("basic3", label = "size = 1", size = 1)
            ),
            div(
              class="col-md-6",
              ratingInput("basic4", label = "size = 3", size = 2)
            )
          ),
          # type
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("basic5", label = "i_name = 'heart', i_lib = 'font-awesome'", i_name = 'heart')
            ),
            div(
              class="col-md-6",
              ratingInput("basic8", label = "i_name = 'cloud', i_lib = 'glyphicon'", i_name = 'cloud', i_lib = 'glyphicon')
            )
          )
        )
      ),
      # value
      card_suite(
        title = "Value",
        body = tagList(
          p("An initial value can be specified to the widget with the 'value' parameter of ratingInput()."),
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("intro1", label = "value = NA")),
            div(
              class="col-md-6",
              ratingInput("intro2", label = "value = 3",value = 3))),
          br(),
          p("This value can be update from the server with the 'value' parameter of updateRatingInput()"),
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("intro3", label = "value = NA", value = 5),
              actionButton("update1","Reset", class="btn-primary")
            ),
            div(
              class="col-md-6",
              ratingInput("intro4", label = "value = 3"),
              actionButton("update2","Update", class="btn-primary")
            )
          )
        )
      ),
      # colors
      card_suite(
        title = "Colors",
        body = tagList(
          p("To parameter your widgets, you can also specify the off and on colors of icons. Colors can be specified as Boostrap 5 names or Hex code."),
          # on color
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("color1", label = "on_color = 'danger'", on_color = 'danger')
            ),
            div(
              class="col-md-6",
              ratingInput("color2", label = "on_color = '#D5AB55'", on_color = '#D5AB55')
            )
          ),
          # off color
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("color3", label = "off_color = 'light'", off_color = 'light')
            ),
            div(
              class="col-md-6",
              ratingInput("color4", label = "off_color = '#add8e6'", off_color = '#add8e6')
            )
          ),
          # off on color
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput(
                inputId = "color5",
                label = "on_color = '#D5AB55', off_color = 'light'",
                off_color = 'light',
                on_color = '#D5AB55'
                )
            ),
            div(
              class="col-md-6",
              ratingInput(
                inputId = "color6",
                label = "on_color = '#D5AB55', off_color = 'black'",
                off_color = 'black',
                on_color = '#D5AB55'
              )
            )
          )
        )
      ),
      # animation
      card_suite(
        title = "Animations & tooltips",
        body = tagList(
          p("To develop emphasis you can add animations on icons click as well as tooltips on hover.
          Available animations are those from the ", tags$a(href="https://animate.style/", target="_blank", "animate.css"),"website."),
          # Animations
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("anim1", label = "anim = 'swing'", anim = "swing")
            ),
            div(
              class="col-md-6",
              ratingInput("anim2", label = "anim = 'swing', duration = 8", anim = "swing", duration = 8)
            )
          ),
          # tooltips
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("tlp1", label = "tlp = TRUE", tlp = TRUE)
            ),
            div(
              class="col-md-6",
              ratingInput("tlp2", label = "tlp = TRUE, tlp_color = 'success'",tlp = TRUE, tlp_color = "success")
            )
          ),
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("tlp3", label = "tlp = TRUE, tlp_position = 'top'",tlp = TRUE, tlp_position = "top")
            ),
            div(
              class="col-md-6",
              ratingInput("tlp4", label = "tlp = TRUE, tlp_msg = c('A','B','C','D','E')",tlp = TRUE, tlp_msg = c('A','B','C','D','E'))
            )
          )

        )
      ),
      # Cumul hover
      card_suite(
        title = "Others options",
        body = tagList(
          p("Others available options to personnalize rating widgets are read-only, hover and cumulation modes, as well as the possibility to individualize previous parameters for each icon."),
          # cumul
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("opt1", label = "cumul = TRUE", cumul = TRUE)
            ),
            div(
              class="col-md-6",
              ratingInput("opt2", label = "cumul = FALSE", cumul = FALSE)
            )
          ),
          # hover
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("opt3", label = "hover = FALSE" , hover = FALSE)),
            div(
              class="col-md-6",
              ratingInput("opt4", label = "hover = TRUE" , hover = TRUE))
          ),
          # read_only
          div(
            class = "row",
            div(
              class="col-md-6",
              ratingInput("opt5", label = "read_only = FALSE" , value = 3, read_only = FALSE)),
            div(
              class="col-md-6",
              ratingInput("opt6", label = "read_only = TRUE" , value = 3, read_only = TRUE))
          ),
          ratingInput(
            inputId = "Mood",
            label = "Individual parameters (see README)",
            number = 5,
            cumul = FALSE,
            hover = TRUE,
            size = 2,
            on_color = c("danger","warning","dark","info","success"),
            off_color = "light",
            i_name = c("angry","frown","meh","smile","laugh"),
            i_lib = "font-awesome",
            anim = "pulse",
            duration = 1,
            tlp = TRUE,
            tlp_color = c("danger","warning","dark","info","success"),
            tlp_position = "bottom",
            tlp_msg = c("Angry","Frown","Neutral","Happy","Excited")
          )
        )
      )
    ),
    br(),
    br()
  ),
  nav_spacer(),
  nav_item(tags$a(href="https://github.com/mhanf/ShinyRating", icon("github",class = "fa-1x")))
)
