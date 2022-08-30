#' Create a rating widget
#' @description Create a rating widget for usage in a Shiny UI.
#' @param inputId The rating widget id.
#' @param number The number of icons in the rating widget.
#' @param i_on_color The icon colors when selected (hex or Bootstrap 5 color).
#' @param i_off_color The icon colors when deselected (hex or Bootstrap 5 color).
#' @param label Display label for the control.
#' @param i_width The icons width in css units.
#' @param i_height The icons height in css units.
#' @param i_name The icon name (fontawesome) or path (local).
#' @param i_lib The icon library to use. Either "fontawesome" or "local".
#' @param width The width of the input, e.g. '400px', or '100%'; see validateCssUnit()
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
#' @return A rating widget for usage in Shiny UI.
#' @export
#'
#' @examples
#' ratingInput(
#'   inputId = "like",
#'   i_name = "heart",
#'   i_on_color = "danger"
#' )
#'
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

  # width
  width <- shiny::validateCssUnit(width)
  # test_pos_integer
  test_pos_integer(number, na_rm = FALSE)
  test_pos_integer(value, na_rm = TRUE)
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
  # test color
  lapply(i_on_color, function(i) {
    if (!i %in% valid_bs5 & !isHex(i)) {
      stop("i_on_color must be a bootstrap or a hex color")
    }
  })
  lapply(i_off_color, function(i) {
    if (!i %in% valid_bs5 & !isHex(i)) {
      stop("i_off_color must be a bootstrap or a hex color")
    }
  })
  # match.arg
  match.arg(
    arg = i_lib,
    choices = c("fontawesome", "local"),
    several.ok = TRUE
  )
  match.arg(
    arg = tlp_position,
    choices = c("top", "bottom", "left", "right"),
    several.ok = TRUE
  )
  match.arg(
    arg = tlp_color,
    choices = valid_bs5,
    several.ok = TRUE
  )
  # test icon dimension
  shiny::validateCssUnit(i_width)
  shiny::validateCssUnit(i_height)
  # test icon margin
  shiny::validateCssUnit(i_margin_left)
  shiny::validateCssUnit(i_margin_right)

  # # test global parameters
  # # inputId
  # test_null(inputId)
  # test_na(inputId)
  # test_character(inputId)
  # # label
  # if (is.character(label) == FALSE & is.null(label) == FALSE){ stop("label must be NULL or a character string") }
  #
  # # number
  # test_null(number)
  # test_na(number)
  # test_pos_integer(number)
  # # value
  # test_null(number)
  # test_pos_integer(number)
  #
  # # test icon parameters
  #
  # ## on_color
  # if (FALSE %in% is.character(on_color)){ stop("on_color must be a character string") }
  # test_length(on_color, number)
  # lapply(on_color,function(i){
  #   if (! i %in% valid_bs5 & !isHex(i)){
  #     stop("on_color must be a bootstrap or a hex color")
  #   }
  # })
  # ## i_off_color
  # if (FALSE %in% is.character(i_off_color)){ stop("i_off_color must be a character string") }
  # test_length(i_off_color, number)
  # lapply(i_off_color,function(i){
  #   if (! i %in% valid_bs5 & !isHex(i)){
  #     stop("i_off_color must be a bootstrap or a hex color")
  #   }
  # })
  # ## size
  # test_length(size, number)
  # match.arg(
  #   arg = size,
  #   choices = 1:5,
  #   several.ok = TRUE
  # )
  # ## i_name
  # test_null(i_name)
  # test_na(i_name)
  # test_length(i_name, number)
  # test_character(i_name)
  # ## i_lib
  # test_null(i_lib)
  # test_na(i_lib)
  # test_length(i_lib, number)
  # ## i_anim
  # test_null(i_anim)
  # test_na(i_anim)
  # test_length(i_anim, number)
  # test_character(i_anim)
  # ## i_duration
  # test_null(i_duration)
  # test_length(i_duration, number)
  # ## tlp
  # test_null(tlp)
  # test_na(anim)
  # test_length(tlp, number)
  # test_logical(tlp)
  # ## i_value
  # test_null(i_value)
  # test_na(i_value)
  # test_length(i_value, number)
  # test_character(i_value)
  # ## tlp_position
  # test_null(tlp_position)
  # test_na(tlp_position)
  # test_length(tlp_position, number)
  # match.arg(
  #   arg = tlp_position,
  #   choices = c("top","bottom","left","right"),
  #   several.ok = TRUE
  #   )
  # ## tlp_color
  # test_null(tlp_color)
  # test_na(tlp_color)
  # test_length(tlp_color, number)
  # match.arg(
  #   arg = tlp_color,
  #   choices = valid_bs5,
  #   several.ok = TRUE
  # )
  # transform bs color
  i_on_color[i_on_color %in% valid_bs5 == TRUE] <- paste0("var(--bs-", i_on_color[i_on_color %in% valid_bs5 == TRUE], ")")
  i_off_color[i_off_color %in% valid_bs5 == TRUE] <- paste0("var(--bs-", i_off_color[i_off_color %in% valid_bs5 == TRUE], ")")

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
      width = width # ,
      # min = 1,
      # max = number
    )
  )$
    find("label")$
    addClass("m-0 p-0")$
    allTags()
  # add attributes and class to the hidden numeric input
  num_tag <- htmltools::tagQuery(num_tag)$
    find("input")$
    addAttrs("number" = number)$
    addClass("rating_input")$
    addClass("d-none")$
    addClass("m-0 p-0")$
    allTags()
  # ratingInput dependency
  rating_dep <- htmltools::htmlDependency(
    name = "rating",
    version = "0.0.1",
    package = "ShinyRating",
    src = "assets",
    script = "rating.js",
    stylesheet = c(file = "rating.css")
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
