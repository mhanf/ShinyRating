#' Create a rating input
#' @description Create a rating input for usage in a Shiny UI.
#' @param inputId The rating input id.
#' @param number The number of icons in the rating input.
#' @param width The width of the input, e.g. '400px', or '100%'; see validateCssUnit()
#' @param i_on_color,i_off_color The off and on icon colors (hex or Bootstrap 5 color).
#' @param label Display label for the control.
#' @param i_width,i_height  The icons width and height in css units.
#' @param i_name The icon name (fontawesome) or path (local).
#' @param i_lib The icon library to use. Either "fontawesome" or "local".
#' @param value The Initial value.
#' @param i_anim The type of animations see \href{https://animate.style/}{Animate.css}.
#' @param i_duration The animation duration in seconds.
#' @param tlp Logical, whether or not to use a tooltip for the icon.
#' @param i_value The character strings to be shown as message.
#' @param tlp_position The tooltip positions, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @param tlp_color The tooltip colors, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param cumul Logical, whether or not to use cumulative color for the icons.
#' @param read_only Logical, whether or not to use a read only mode for the icons.
#' @param hover Logical, whether or not to use a hover mode for the icons.
#' @param i_margin_left,i_margin_right The length value for the margin that's either
#' left or right of the icon. By default, \code{"auto"} is used for both
#' properties. If space is needed on either side then a length of \code{"0.2em"} is
#' recommended as a starting point.
#' @import shiny
#' @importFrom bslib bs_theme
#' @importFrom htmltools parseCssColors
#' @return A rating input for usage in Shiny UI.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(bslib)
#'   library(ShinyRating)
#'
#'   ui <- fluidPage(
#'     theme = bslib::bs_theme(version = 5, bootwatch = "flatly"),
#'     ratingInput(
#'       inputId = "id1",
#'       i_name = "star",
#'       i_on_color = "danger"
#'     ),
#'     shiny::actionButton("update", "Update")
#'   )
#'   server <- function(input, output, session) {
#'     shiny::observeEvent(input$update, {
#'       updateRatingInput(session = session, inputId = "id1", value = 4)
#'     })
#'   }
#'   shiny::shinyApp(ui, server)
#' }

ratingInput <- function( # global parameters
                        inputId,
                        label = NULL,
                        width = "auto",
                        number = 5,
                        value = NA,
                        cumul = FALSE,
                        read_only = FALSE,
                        hover = FALSE,
                        # icon parameters
                        i_on_color = "success",
                        i_off_color = "dark",
                        i_width = NULL,
                        i_height = NULL,
                        i_name = "star",
                        i_lib = "fontawesome",
                        i_anim = "none",
                        i_duration = 2,
                        i_value = 1:number,
                        i_margin_left = "auto",
                        i_margin_right = "auto",
                        # tooltip parameters
                        tlp = FALSE,
                        tlp_position = "bottom",
                        tlp_color = "black") {
  # test_pos_integer
  test_pos_integer(number, na_rm = FALSE)
  # test_logical
  test_logical(tlp)
  test_logical(cumul)
  test_logical(read_only)
  test_logical(hover)
  ## valid bs color
  valid_bs5 <- c("primary", "secondary", "info", "warning", "danger", "success", "light", "dark", "black", "white")
  # test_length
  test_length(i_on_color, number)
  test_length(i_off_color, number)
  if (is.null(i_width) == FALSE) {
    test_length(i_width, number)
  }
  if (is.null(i_height) == FALSE) {
    test_length(i_height, number)
  }
  test_length(i_name, number)
  test_length(i_lib, number)
  test_length(i_anim, number)
  test_length(i_duration, number)
  test_length(tlp, number)
  test_length(i_value, number)
  test_length(tlp_position, number)
  test_length(tlp_color, number)
  test_length(i_margin_left, number)
  test_length(i_margin_right, number)
  # test on color
  for(i in 1:length(i_on_color)){
    if (!i_on_color[i] %in% valid_bs5){
      i_on_color[i] <- htmltools::parseCssColors(i_on_color[i], mustWork = TRUE)
    }
    else {
      i_on_color[i] <- sprintf("var(--bs-%s)",i_on_color[i])
    }
  }
  # test off color
  for(i in 1:length(i_off_color)){
    if (!i_off_color[i] %in% valid_bs5){
      i_off_color[i] <- htmltools::parseCssColors(i_off_color[i], mustWork = TRUE)
    }
    else {
      i_off_color[i] <- sprintf("var(--bs-%s)",i_off_color[i])
    }
  }
  # test icon library
  lapply(i_lib, function(i) {
    match.arg(
      arg = i,
      choices = c("fontawesome", "local"),
      several.ok = TRUE
    )
  })
  # test tooltip position
  lapply(tlp_position, function(i) {
    match.arg(
      arg = i,
      choices = c("top", "bottom", "left", "right"),
      several.ok = TRUE
    )
  })
  # test tooltip color
  lapply(tlp_color, function(i) {
    match.arg(
      arg = i,
      choices = valid_bs5,
      several.ok = TRUE
    )
  })
  # test icon dimension
  lapply(i_width, function(i) {
    shiny::validateCssUnit(i)
  })
  lapply(i_height, function(i) {
    shiny::validateCssUnit(i)
  })
  # test icon margin
  lapply(i_margin_left, function(i) {
    shiny::validateCssUnit(i)
  })
  lapply(i_margin_right, function(i) {
    shiny::validateCssUnit(i)
  })
  # create list of clickable icons
  rating_tag <- shiny::tagList(
    shiny::div(label),
    createRating(
      rating_id = inputId,
      number = number,
      cumul = cumul,
      read_only = read_only,
      hover = hover,
      init_value = value,
      tlp = tlp,
      i_name = i_name,
      i_lib = i_lib,
      i_margin_left = i_margin_left,
      i_margin_right = i_margin_right,
      i_on_color = i_on_color,
      i_off_color = i_off_color,
      i_width = i_width,
      i_height = i_height,
      i_anim = i_anim,
      i_duration = i_duration,
      i_value = i_value,
      tlp_position = tlp_position,
      tlp_color = tlp_color
    )
  )
  # create the hidden numeric input
  num_tag <- htmltools::tagQuery(
    shiny::textInput(
      inputId = inputId,
      label = rating_tag,
      value = value,
      width = width
    )
  )$
    find("label")$
    #addClass("m-0 p-0")$
    addAttrs("style" = "margin: 0; padding: 0;")$
    allTags()
  # add attributes and class to the hidden numeric input
  num_tag <- htmltools::tagQuery(num_tag)$
    find("input")$
    addAttrs("number" = number)$
    addClass("rating_input")$
    addAttrs("style" = "display: none; margin: 0; padding: 0;")$
    allTags()
  # ratingInput dependency
  rating_dep <- htmltools::htmlDependency(
    name = "rating",
    version = "0.0.1",
    package = "ShinyRating",
    src = "assets",
    script = "rating.js"
    )
  # animate dependency
  animate_dep <- htmltools::htmlDependency(
    name = "animate",
    version = "4.1.1",
    package = "ShinyRating",
    src = "assets",
    stylesheet = c(file = "animate.css")
  )
  # Attach dependencies
  final_tag <- tagList(rating_dep, animate_dep, num_tag)
  # return
  return(final_tag)
}
