ui <- shiny::navbarPage(
  "ShinyRating",
  theme = theme,
  tabPanel(
    "Gallery",
    bslib::navs_pill_list(
      well = FALSE,
      fluid = FALSE,
      widths = c(2, 10),
      # basics page
      nav("Overview",
          card_suite(
            title = "Overview",
            body = tagList(
              div(class = "bg-light p-1",
                  "The number of icons is set with the ",
                  tags$code("number"),
                  " parameter."
              ),
              # number
              fluidRow(
                ratingInput2(inputId = "basic1", label = "number = 3", number = 3),
                ratingInput2(inputId = "basic2", label = "number = 5", number = 5),
                ratingInput2(inputId = "basic3", label = "number = 7", number = 7)
              ),
              br(),
              div(class = "bg-light p-1",
                  "The width and height of icons are specified with the ",
                  tags$code("i_width"),
                  " and ",
                  tags$code("i_height"),
                  " parameters (CSS units)."
              ),
              # size
              fluidRow(
                ratingInput2(inputId = "basic4", label = "i_width = '1.5em'", i_width = "1.5em"),
                ratingInput2(inputId = "basic5", label = "i_height = '30px'", i_height = '30px'),
                ratingInput2(inputId = "basic6", label = "i_width = '1em', i_height = '1.5em'", i_width = '1em', i_height = '1.5em')
              ),
              br(),
              # type
              div(class = "bg-light p-1",
                  "The type of icons is set with the ",
                  tags$code("i_name"),
                  " parameter. Available icons are those from fontawesome 6.1.2."
              ),
              fluidRow(
                ratingInput2(inputId = "basic7", label = "i_name = 'heart'", i_name = "heart"),
                ratingInput2(inputId = "basic8", label = "i_name = 'cloud'", i_name = 'cloud'),
                ratingInput2(inputId = "basic9", label = "i_name = 'cat'", i_name = 'cat')
              ),
              br(),
              # color
              div(class = "bg-light p-1",
                  "The off and on colors of icons are set with the ",
                  tags$code("i_color_off"),
                  " and ",
                  tags$code("i_color_off"),
                  " parameters (boostrap 5 names or hex codes)."),
              fluidRow(
                ratingInput2(inputId = "basic10", label = "i_on_color = '#D5AB55'", i_on_color = "#D5AB55"),
                ratingInput2(inputId = "basic11", label = "i_off_color = 'light'", i_off_color = "light"),
                ratingInput2(inputId = "basic12", label = "i_on_color = '#D5AB55', i_off_color = 'light'", i_on_color = "#D5AB55", i_off_color = "light")
              )
            )
          )
      ),
      # value page
      nav("Value",card_suite(
        title = "Value",
        body = tagList(
          div(class = "bg-light p-1",
              "An initial value can be specified to the input with the",
              tags$code("value"),
              " parameter of ",
              tags$code("ratingInput()"),
              "."),
          div(class = "bg-light p-1",
              "Icon values can also be personnalized with the ",
              tags$code("i_value"),
              " parameter."),
          fluidRow(
            ratingInput2(inputId = "Value1", label = "value = NA"),
            ratingInput2(inputId = "Value2", label = "value = 3", value = 3),
            ratingInput2(inputId = "Value3", label = "i_value = c('A', 'B', 'C', 'D', 'E')", i_value = c('A','B','C','D','E'))
          ),
          fluidRow(
            div(class = "col-md-4",textOutput("update1")),
            div(class = "col-md-4",textOutput("update2")),
            div(class = "col-md-4",textOutput("update3"))
          ),
          br(),
          div(class = "bg-light p-1",
              "The input value can be accessed from the server with ",
              tags$code("input$InputId"),
              "."),
          div(class = "bg-light p-1",
              "This value can also be updated from the server with the ",
              tags$code("value"),
              " parameter of ",
              tags$code("updateRatingInput()"),
              "."),
          fluidRow(
            ratingInput2(inputId = "Value4", label = "Observe on input$InputId"),
            ratingInput2(inputId = "Value5", label = "value = NA", value = NA),
            ratingInput2(inputId = "Value6", label = "value = 5", value = NA),
          ),
          fluidRow(
            div(class = "col-md-4",textOutput("update4")),
            actionButton2(inputId = "reset", label = "Reset", class = "btn-primary"),
            actionButton2(inputId = "update", label = "Update", class = "btn-primary")
          ),
          br(),
          div(class = "bg-light p-1", "Rating inputs are compatible with input validation from ",
              tags$a("shinyvalidate", href="https://rstudio.github.io/shinyvalidate/",  target = "_blank"),
              " package."),
          fluidRow(
            ratingInput2(inputId = "validate1",label = "Value is required"),
            ratingInput2(inputId = "validate2", label = "Value must be greater than 3"),
            ratingInput2(inputId = "validate3", label = "value must be equal to 2")
          )
        )
      )),
      nav("Visual effects",
          card_suite(title = "Visual effects",
                     body = tagList(
                       div(class = "bg-light p-1",
                           "You can add animations on icons click with ",
                           tags$code("i_anim"),
                           " and ",
                           tags$code("i_duration"),
                           " parameters. Available animations are those from the ",
                           tags$a(href = "https://animate.style/", target = "_blank", "animate.css"),
                           "website."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "effect1", label = "i_anim = 'swing'", i_anim = "swing"),
                         ratingInput2(inputId = "effect2", label = "i_anim = 'tada'", i_anim = "tada"),
                         ratingInput2(inputId = "effect3", label = "i_anim = 'swing', i_duration = 8", i_anim = "swing", i_duration = 8)
                       ),
                       br(),
                       div(class = "bg-light p-1",
                           "You can add tootip on icons hover with ",
                           tags$code("tlp"),
                           ", ",
                           tags$code("tlp_color"),
                           " and ",
                           tags$code("tlp_position"),
                           " parameters (only bootstrap 5 colors)."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "tlp1", label = "tlp = TRUE", tlp = TRUE),
                         ratingInput2(inputId = "tlp2", label = "tlp = TRUE, tlp_color = 'success'", tlp = TRUE, tlp_color = "success"),
                         ratingInput2(inputId = "tlp3", label = "tlp = TRUE, tlp_position = 'top'", tlp = TRUE, tlp_position = "top")
                       ),
                       br(),
                       div(class = "bg-light p-1",
                           "Read-only, hover and cumulation modes are available with ",
                           tags$code("read_only"),
                           ", ",
                           tags$code("hover"),
                           " and ",
                           tags$code("cumul"),
                           " parameters."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "effect4", label = "read_only = TRUE", value = 3, read_only = TRUE),
                         ratingInput2(inputId = "effect5", label = "hover = TRUE", hover = TRUE),
                         ratingInput2(inputId = "effect6", label = "cumul = TRUE", cumul = TRUE)
                       ),
                       br(),
                       div(class = "bg-light p-1",
                           "The left and right margins of icons are specified with the ",
                           tags$code("i_margin_left"),
                           " and ",
                           tags$code("i_margin_right"),
                           " parameters (CSS units)."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "effect7", label = "i_margin_left = '0.5em'", i_margin_left = '0.5em'),
                         ratingInput2(inputId = "effect8", label = "i_margin_right = '20px'", i_margin_right = '20px'),
                         ratingInput2(inputId = "effect9", label = "i_margin_left = '0.5em', i_margin_right = '0.5em'", i_margin_left = '0.5em', i_margin_right = '0.5em')
                       )
                     )
          )),
      nav("Advanced use",
          card_suite(title = "Advanced use",
                     body = tagList(
                       div(class = "bg-light p-1",
                           "You can use user-defined svg icons with the ",
                           tags$code("i_name"),
                           " and ",
                           tags$code("i_lib"),
                           " parameters."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "svg1", label = "i_name = 'www/starwars.svg', i_lib = 'local'", i_name = 'www/starwars.svg', i_lib = 'local'),
                         ratingInput2(inputId = "svg2", label = "i_name = 'www/dragon.svg', i_lib = 'local'", i_name = 'www/dragon.svg', i_lib = 'local'),
                         ratingInput2(inputId = "svg3", label = "i_name = 'www/minion.svg', i_lib = 'local'", i_name = 'www/minion.svg', i_lib = 'local')
                       ),
                       br(),
                       div(class = "bg-light p-1",
                           "All ",
                           tags$code("i_"),
                           " and ",
                           tags$code("tlp_"),
                           " parameters can be defined individually for each icon."
                       ),
                       fluidRow(
                         ratingInput2(inputId = "svg4", label = "i_on_color = c('danger','warning','primary','info','success')", i_on_color = c('danger','warning','primary','info','success')),
                         ratingInput2(inputId = "svg5", label = "i_name = c('cow','hippo','otter','cat','dog')", i_name = c('cow','hippo','otter','cat','dog')),
                         ratingInput2(inputId = "svg6", label = "tlp_color = c('danger','warning','primary','info','success')", tlp = TRUE, tlp_color = c('danger','warning','primary','info','success'))
                       ),
                       fluidRow(
                         ratingInput2(inputId = "svg7", label = "i_width = c('1.2em','1.4em','1.6em','1.8em','2em')", i_width = c('1.2em','1.4em','1.6em','1.8em','2em')),
                         ratingInput2(inputId = "svg8", label = "i_margin_left = c('0em','0.4em','0.8em','1.2em','1.6em')", i_margin_left = c('0em','0.4em','0.8em','1.2em','1.6em')),
                         ratingInput2(inputId = "svg9", label = "i_anim = c('bounce','flash','pulse','tada','jello')", i_anim = c('bounce','flash','pulse','tada','jello'))
                       ),
                       br(),
                       div(class = "bg-light p-1", "You can now play with ShinyRating, have fun !"),
                       fluidRow(
                         ratingInput2(
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
                         ratingInput2(
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
                         ratingInput2(
                           inputId = "animal",
                           label = "What is your favorite animal ?",
                           i_width = "2.5em",
                           i_name = c("cow","hippo","otter","cat","dog"),
                           i_anim = "heartBeat",
                           i_margin_left = "0.5em",
                           i_margin_right = "0.5em",
                           i_off_color = "black",
                           i_on_color = "danger",
                           tlp = TRUE,
                           tlp_color = "white",
                           i_value = c("Cow","Hippo","Otter","Cat","Dog")
                         ),
                         br()
                       )


                     )
          )
      )
    )),
  nav_spacer(),
  nav_item(tags$a(href = "https://github.com/mhanf/ShinyRating", fontawesome::fa("github", width = "1.3em",position = "relative")))
)
