#' create an icon
#'
#' @param id icon id
#' @param i_name Name of the icon.
#' @param i_lib The icon library to use. Either "font-awesome" or "glyphicon".
#' @param i_number Icon number
#' @param number Number of icons in rating input control
#' @param rating_id Rating input control id
#' @param on_color Selection color of icon (hex or Boostrap 5 color)
#' @param off_color Default color of icon (hex or Boostrap 5 color)
#' @param init_color Initial color of icon (hex or Boostrap 5 color)
#' @param size Size of the icons (1 to 5)
#' @param anim Type of animation from animate.css library (https://animate.style/)
#' @param duration Duration of the animation
#' @param tlp Tooltip for the icons (TRUE or FALSE)
#' @param tlp_msg Tooltip messages
#' @param tlp_position Tooltip positions
#' @param tlp_color Tooltip colors
#' @param cumul Cumulative color for icons (TRUE or FALSE)
#' @param read_only Read Only mode for icons (TRUE or FALSE)
#' @param hover Hover for icons (TRUE or FALSE)
#'
#' @import shiny
#' @return a rating icon
#'

createIcon <- function(
  id,
  i_name = "star",
  i_lib = "font-awesome",
  i_number = 1,
  number = 10,
  rating_id,
  on_color = "primary",
  off_color = "dark",
  init_color = "dark",
  size = 2,
  anim = "none",
  duration = 2,
  cumul = TRUE,
  tlp = FALSE,
  tlp_msg = 1,
  tlp_position = "top",
  tlp_color = "black",
  read_only = FALSE,
  hover = FALSE
){
  # definition of the size class
  if (i_lib == "font-awesome"){ type <-"fa" } else{ type <- "gi" }
  # definition of the hover class
  if (isTRUE(hover)){ hover_class <- "hover_rating" }
  else { hover_class <- "" }
  # definition of the read only style
  if (isTRUE(read_only)) { read_style <- "pointer-events: none; cursor: default;" }
  else { read_style <- "" }

  # create the icon
  tag <- shiny::icon(
    id = id,
    name = i_name,
    lib = i_lib,
    i_number = i_number,
    number = number,
    disabled = 'true',
    rating_id = rating_id,
    on_color = on_color,
    off_color = off_color,
    cumulation = tolower(cumul),
    anim = anim,
    type="button",
    class= sprintf("m-0 p-0 action-button btn_rating %s-%sx %s", type, size, hover_class),
    style = sprintf(fmt = "color: %s; --animate-duration: %ss; %s",
                    init_color,
                    duration,
                    read_style
    )
  )
  # add tooltip if needed
  if (tlp == TRUE){
    tag <- addTooltip(tag,
                       tlp_color = tlp_color,
                       tlp_msg = tlp_msg,
                       tlp_position = tlp_position)
  }

  return(tag)
}
