library(shiny)
library(shinyvalidate)
library(ShinyRating)

ui <- function(){
    fluidPage(
        theme = bslib::bs_theme(version = 5,bootswatch = "simplex"),
        br(),
        br(),
        h4("Tooltip position",class = "text-primary"),
        ratingInput(
            inputId = "test",
            label = "Comment avez vous trouvez la formation ?",
            size = 2,
            width ="auto",
            on_color = "info",
            off_color = "dark",
            i_name = c("angry","frown","meh","smile","laugh"),
            i_lib = "font-awesome",
            anim = "tada",
            duration = 1,
            number = 5,
            cumul = FALSE,
            value = 4,
            tlp = TRUE,
            tlp_color = c("info","primary","warning","danger","success"),
            tlp_position = "bottom",
            tlp_msg = c("Horrible","Pas ouf","Moyen","Bien", "De la balle")
        ),
        textOutput("test_result"),
        ratingInput("essai",
                    size = 2,
                    anim = "tada",
                    i_name = "star",
                    on_color = "success",
                    cumul = TRUE
        ),
        textOutput("essai_result"),
        actionButton("go","Restore")
    )
}

server <- function(input, output, session) {

    iv <- InputValidator$new()
    iv$add_rule("essai", sv_required())
    iv$enable()

    observe({
        output$test_result <- renderText({sprintf("Votre réponse est : %s",input$test)})
    })

    observe({
        output$essai_result <- renderText({sprintf("Votre réponse est : %s",input$essai)})
    })

    observeEvent( input$go , {
        updateRatingInput(session, "test", NA)
        updateRatingInput(session, "essai", 2)
    })
}

shinyApp(ui = ui, server = server)
