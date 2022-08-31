# serveur
server <- function(input, output, session) {
  observeEvent(
    input$reset,
    {
      updateRatingInput(session, "Value5")
    }
  )
  observeEvent(
    input$update,
    {
      updateRatingInput(session, "Value6", value = 5)
    }
  )
  observe({
    output$update1 <- renderText(paste0("Response : ",input$Value1))
  })
  observe({
    output$update2 <- renderText(paste0("Response : ",input$Value2))
  })
  observe({
    output$update3 <- renderText(paste0("Response : ",input$Value3))
  })
  observe({
    output$update4 <- renderText(paste0("Response : ",input$Value4))
  })
}
