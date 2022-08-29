#' Create an icon
#' @description Create an icon for usage in \code{\link{createRating}}.
#'
#' @param id The icon id.
#' @param i_name The icon name (fontawesome) or path (local).
#' @param i_lib The icon library to use. Either "fontawesome" or "local".
#' @param i_number The icon place in the rating widget.
#' @param number The total number of icons in the rating widget.
#' @param rating_id The rating widget id.
#' @param on_color The icon color when selected (hex or Bootstrap 5 color).
#' @param off_color The icon color when deselected (hex or Bootstrap 5 color).
#' @param init_color The icon initial color (hex or Bootstrap 5 color).
#' @param i_width The icon width in css units.
#' @param i_height The icon height in css units.
#' @param anim The type of animation see \href{https://animate.style/}{Animate.css}.
#' @param duration The animation duration in seconds.
#' @param tlp Logical, whether or not to use a tooltip for the icon.
#' @param tlp_msg The character string to be shown as message in the tooltip.
#' @param tlp_position The tooltip position, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @param tlp_color The tooltip color, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param cumul Logical, whether or not to use cumulative color for the icon.
#' @param read_only Logical, whether or not to use a read only mode for the icon.
#' @param hover Logical, whether or not to use a hover mode for the icon.
#'
#' @importFrom fontawesome fa
#' @return  A \code{shiny.tag} object for usage in \code{\link{createRating}}
#'

createIcon <- function(id,
                       i_name = "star",
                       i_lib = "fontawesome",
                       i_number = 1,
                       number = 10,
                       rating_id,
                       on_color = "primary",
                       off_color = "dark",
                       init_color = "dark",
                       #size = "2em",
                       i_width = NULL,
                       i_height = NULL,
                       anim = "none",
                       duration = 2,
                       cumul = FALSE,
                       tlp = FALSE,
                       tlp_msg = 1,
                       tlp_position = "top",
                       tlp_color = "black",
                       read_only = FALSE,
                       hover = FALSE) {

  # definition of the hover class
  if (isTRUE(hover)) {
    hover_class <- "hover_rating"
  } else {
    hover_class <- ""
  }
  # definition of the read only style
  if (isTRUE(read_only)) {
    read_style <- "pointer-events: none; cursor: default;"
  } else {
    read_style <- ""
  }
  # i_width standardization
  if (is.null(i_width) == TRUE & is.null(i_height) == TRUE){
    i_width = "2em"
  }
  # compilation of svg
  if (i_lib == "fontawesome"){
    tag <- fontawesome::fa(
      name = i_name,
      height = i_height,
      width = i_width)
  }
  else if (i_lib == "local"){
    tag <- read_icon(i_name, i_height = i_height, i_width = i_width)
  }
  # span of svg
  tag <- tags$span(
    id = id,
    name = i_name,
    lib = i_lib,
    i_number = i_number,
    number = number,
    disabled = "true",
    rating_id = rating_id,
    on_color = on_color,
    off_color = off_color,
    cumulation = tolower(cumul),
    anim = anim,
    type = "button",
    class = sprintf(
      "m-0 p-0 action-button btn_rating %s",
      hover_class
    ),
    style = sprintf(
      fmt = "color: %s; --animate-duration: %ss; %s;",
      init_color,
      duration,
      read_style
    ),
    tag
  )

  # add tooltip if needed
  if (isTRUE(tlp)) {
    tag <- addTooltip(
      tag,
      tlp_color = tlp_color,
      tlp_msg = tlp_msg,
      tlp_position = tlp_position
    )
  }

  return(tag)
}
