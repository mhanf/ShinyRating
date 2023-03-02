#' Create rating icons
#' @description Create rating icons for usage in \code{\link{ratingInput}}.
#' @param rating_id The rating input id.
#' @param i_name The icon name (fontawesome) or path (local).
#' @param i_lib The icon library to use. Either "fontawesome" or "local".
#' @param number The number of icons in the rating input.
#' @param init_value The Initial value of the rating input.
#' @param i_on_color The icon colors when selected (hex or Bootstrap 5 color).
#' @param i_off_color The icon colors when deselected (hex or Bootstrap 5 color).
#' @param i_width The icons width in css units.
#' @param i_height The icons height in css units.
#' @param i_anim The type of animations see \href{https://animate.style/}{Animate.css}.
#' @param i_duration The animation duration in seconds.
#' @param tlp Logical, whether or not to use a tooltip for the icon.
#' @param i_value The character strings to be shown as message.
#' @param tlp_position The tooltip positions, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @param tlp_color The tooltip colors, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param cumul Logical, whether or not to use cumulative color for the icons.
#' @param read_only Logical, whether or not to use a read only mode for the icons.
#' @param i_prefer_type The type of icon returned in case of fontawesome lib, \code{"regular"} or \code{"solid"}
#' @param hover Logical, whether or not to use a hover mode for the icons.
#' @param i_margin_left,i_margin_right The length value for the margin that's either
#' left or right of the icon. By default, \code{"auto"} is used for both
#' properties. If space is needed on either side then a length of \code{"0.2em"} is
#' recommended as a starting point.
#' @import shiny
#' @return A \code{shiny.tag} object for usage in \code{\link{ratingInput}}
#' @noRd
createRating <- function(rating_id,
                         i_name = "star",
                         i_prefer_type = "solid",
                         i_lib = "fontawesome",
                         number = 10,
                         init_value = 0,
                         i_on_color = "primary",
                         i_off_color = "dark",
                         i_width = NULL,
                         i_height = NULL,
                         i_anim = "none",
                         i_duration = 2,
                         cumul = FALSE,
                         tlp = FALSE,
                         i_value = 1:number,
                         i_margin_left = "auto",
                         i_margin_right = "auto",
                         tlp_position = "top",
                         tlp_color = "black",
                         read_only = FALSE,
                         hover = FALSE) {
  # transform parameters into vectors
  if (length(i_name) == 1) {
    i_name <- rep(i_name, number)
  }
  if (length(i_prefer_type) == 1) {
    i_prefer_type <- rep(i_prefer_type, number)
  }
  if (length(i_value) == 1) {
    i_value <- rep(i_value, number)
  }
  if (length(tlp_position) == 1) {
    tlp_position <- rep(tlp_position, number)
  }
  if (length(tlp_color) == 1) {
    tlp_color <- rep(tlp_color, number)
  }
  if (length(tlp) == 1) {
    tlp <- rep(tlp, number)
  }
  if (length(i_off_color) == 1) {
    i_off_color <- rep(i_off_color, number)
  }
  if (length(i_on_color) == 1) {
    i_on_color <- rep(i_on_color, number)
  }
  if (length(i_anim) == 1) {
    i_anim <- rep(i_anim, number)
  }
  if (length(i_duration) == 1) {
    i_duration <- rep(i_duration, number)
  }
  if (length(i_width) == 1) {
    i_width <- rep(i_width, number)
  }
  if (length(i_height) == 1) {
    i_height <- rep(i_height, number)
  }
  if (length(read_only) == 1) {
    read_only <- rep(read_only, number)
  }
  if (length(i_margin_left) == 1) {
    i_margin_left <- rep(i_margin_left, number)
  }
  if (length(i_margin_right) == 1) {
    i_margin_right <- rep(i_margin_right, number)
  }
  # lapply
  tag <- lapply(1:number, function(i) {
    # definition of initial color
    if (i <= init_value & !is.na(init_value) & cumul == TRUE) {
      init_color <- i_on_color[i]
    } else if (i == init_value & !is.na(init_value) & cumul == FALSE) {
      init_color <- i_on_color[i]
    } else {
      init_color <- i_off_color[i]
    }
    # icon creation
    createIcon(
      id = paste0(rating_id, i),
      i_name = as.character(i_name[i]),
      i_prefer_type = i_prefer_type[i],
      i_lib = i_lib,
      i_number = i,
      number = number,
      rating_id = rating_id,
      i_on_color = i_on_color[i],
      i_off_color = i_off_color[i],
      init_color = init_color,
      i_width = i_width[i],
      i_height = i_height[i],
      i_anim = i_anim[i],
      i_duration = i_duration[i],
      i_margin_left = i_margin_left[i],
      i_margin_right = i_margin_right[i],
      cumul = cumul,
      tlp = tlp[i],
      i_value = i_value[i],
      tlp_position = tlp_position[i],
      tlp_color = tlp_color[i],
      read_only = read_only[i],
      hover = hover
    )
  })
  # margin adaptation and flex
  tag <- div(
    style = "display: flex; justify-content: center;align-items: center; margin: 2 0 0 0; padding: 0;",
    tag
  )
  # return
  return(tag)
}
