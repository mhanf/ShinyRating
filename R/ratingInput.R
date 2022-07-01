#' Create a rating widget
#' @description Create a rating widget for usage in a Shiny UI.
#' @param inputId The rating widget id.
#' @param number The number of icons in the rating widget.
#' @param on_color The icon colors when selected (hex or Bootstrap 5 color).
#' @param off_color The icon colors when deselected (hex or Bootstrap 5 color).
#' @param label Display label for the control.
#' @param size The icon sizes (1 to 5).
#' @param i_name The icon names.
#' @param i_lib The icon library to use. Either "font-awesome" or "glyphicon".
#' @param width The width of the input, e.g. '400px', or '100%'; see validateCssUnit()
#' @param value The Initial value.
#' @param anim The type of animations see \href{https://animate.style/}{Animate.css}.
#' @param duration The animation duration in seconds.
#' @param tlp Logical, whether or not to use a tooltip for the icon.
#' @param tlp_msg The character strings to be shown as message in tooltips.
#' @param tlp_position The tooltip positions, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @param tlp_color The tooltip colors, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param cumul Logical, whether or not to use cumulative color for the icons.
#' @param read_only Logical, whether or not to use a read only mode for the icons.
#' @param hover Logical, whether or not to use a hover mode for the icons.
#' @import shiny
#' @return A rating widget for usage in Shiny UI.
#' @export
#'
#' @examples
#' ratingInput(
#' inputId = "like",
#' i_name = "heart",
#' on_color = "danger"
#' )

ratingInput <- function(
  inputId,
  number = 5,
  on_color = "success",
  off_color = "dark",
  label = NULL,
  size = 2,
  i_name = "star",
  i_lib = "font-awesome",
  width = "auto",
  value = NA,
  anim = "none",
  duration = 2,
  cumul = TRUE,
  tlp = FALSE,
  tlp_msg = 1:number,
  tlp_position = "bottom",
  tlp_color = "black",
  read_only = FALSE,
  hover = FALSE
){
  # test width
  width <- shiny::validateCssUnit(width)
  # valid bootstrap color
  valid_bs5 <- c("primary","secondary","info","warning","danger","success","light","dark","black","white")

  # # test number
  # if (is.na(as.numeric(number))) {
  #   stop("number must be integer")
  # }
  # if (as.integer(number) != number) {
  #   stop("number must be integer")
  # }
  # if (number < 0) {
  #   stop("number must be > 0")
  # }
  # # bootstrap color
  # # test onColor
  # lapply(on_color,function(i){
  #   if (! i %in% valid_bs5 & !isHex(i)){
  #     stop("on_color must be a bootstrap or a hex color")
  #   }
  # })
  # # test offColor
  # lapply(off_color,function(i){
  #   if (! i %in% valid_bs5 & !isHex(i)){
  #     stop("off_color must be a bootstrap or a hex color")
  #   }
  # })
  # # test i_lib
  # if (! i_lib %in% c("font-awesome","glyphicon")){
  #   stop("i_lib must be font-awesome or glyphicon")
  # }
  # # test size
  # if (TRUE %in% is.na(as.numeric(size))) {
  #   stop("size must be integer")
  # }
  # if (as.integer(size) != size) {
  #   stop("size must be integer")
  # }
  # if (size < 0) {
  #   stop("size must be > 0")
  # }
  # if (size > 5) {
  #   stop("size must be < 6")
  # }
  # # test i_name
  # if (length(i_name) > 1 & length(i_name) != number){
  #   stop("i_name length must be 1 or equal to number parameter")
  # }
  # # test anim
  # if (is.character(anim) == FALSE){
  #   stop("anim must be a character string and one valid animate fr")
  # }
  # # test duration
  # if (is.numeric(duration) == FALSE | duration < 0){
  #   stop("duration must be numeric and > 0")
  # }
  # # test cumul
  # if (is.logical(cumul) == FALSE){
  #   stop("cumul must be logical (TRUE or FALSE)")
  # }

  # transform bs color
  on_color[on_color %in% valid_bs5 == TRUE] <- paste0("var(--bs-",on_color[on_color %in% valid_bs5 == TRUE],")")
  off_color[off_color %in% valid_bs5 == TRUE] <- paste0("var(--bs-",off_color[off_color %in% valid_bs5 == TRUE],")")

  # create list of clickable icons
  rating_tag <- shiny::tagList(
    shiny::div(label),
    createRating(
      rating_id = inputId,
      i_name = i_name,
      i_lib = i_lib,
      number = number,
      init_value = value,
      on_color = on_color,
      off_color = off_color,
      size = size,
      anim = anim,
      duration = duration,
      cumul = cumul,
      tlp = tlp,
      tlp_msg = tlp_msg,
      tlp_position = tlp_position,
      tlp_color = tlp_color,
      read_only = read_only,
      hover = hover
    )
  )
  # create the hidden numeric input
  num_tag <- htmltools::tagQuery(
    shiny::numericInput(
      inputId = inputId,
      label = rating_tag,
      value = value,
      width = width,
      min = 1,
      max = number))$
    find("label")$
    addClass("m-0 p-0")$
    allTags()
  # add attributes and class to the hidden numeric input
  num_tag <- htmltools::tagQuery(num_tag)$
    find("input")$
    addAttrs('number' = number)$
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
    stylesheet =  c(file = "rating.css")
  )
  # animate dependency
  animate_dep <- htmltools::htmlDependency(
    name = "animate",
    version = "4.1.1",
    package = "ShinyRating",
    src = "assets",
    stylesheet =  c(file = "animate.css")
  )
  # Attach dependencies
  final_tag <- tagList(rating_dep, animate_dep, num_tag)
  # return
  return(final_tag)
}
