# serveur
server <- function(input, output, session) {
  observeEvent(
    input$update1, {
      updateRatingInput(session, "intro3")
    }
  )
  observeEvent(
    input$update2, {
      updateRatingInput(session, "intro4", value = 3)
    }
  )
}
