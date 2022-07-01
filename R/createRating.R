#' Create rating icons
#' @description Create rating icons for usage in \code{\link{ratingInput}}.
#' @param rating_id The rating widget id.
#' @param i_name The icon names.
#' @param i_lib The icon library to use. Either "font-awesome" or "glyphicon".
#' @param number The number of icons in the rating widget.
#' @param init_value The Initial value of the rating widget.
#' @param on_color The icon colors when selected (hex or Bootstrap 5 color).
#' @param off_color The icon colors when deselected (hex or Bootstrap 5 color).
#' @param size The icon sizes (1 to 5).
#' @param anim The type of animations see \href{https://animate.style/}{Animate.css}.
#' @param duration The animation durations in seconds.
#' @param tlp Logical, whether or not to use a tooltip for the icon.
#' @param tlp_msg The character strings to be shown as message in tooltips.
#' @param tlp_position The tooltip positions, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @param tlp_color The tooltip colors, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param cumul Logical, whether or not to use cumulative color for the icon.
#' @param read_only Logical, whether or not to use a read only mode for the icons.
#' @param hover Logical, whether or not to use a hover mode for the icons.
#' @import shiny
#' @return A \code{shiny.tag} object for usage in \code{\link{ratingInput}}

createRating <- function(rating_id,
                         i_name = "star",
                         i_lib = "font-awesome",
                         number = 10,
                         init_value = 0,
                         on_color = "primary",
                         off_color = "dark",
                         size = 2,
                         anim = "none",
                         duration = 2,
                         cumul = FALSE,
                         tlp = FALSE,
                         tlp_msg = 1:number,
                         tlp_position = "top",
                         tlp_color = "black",
                         read_only = FALSE,
                         hover = FALSE
){
  # transform parameters into vectors
  if(length(i_name) == 1){ i_name <- rep(i_name, number) }
  if(length(tlp_msg) == 1){ tlp_msg <- rep(tlp_msg, number) }
  if(length(tlp_position) == 1){ tlp_position <- rep(tlp_position, number) }
  if(length(tlp_color) == 1){ tlp_color <- rep(tlp_color, number) }
  if(length(tlp) == 1){ tlp <- rep(tlp, number) }
  if(length(off_color) == 1){ off_color <- rep(off_color, number) }
  if(length(on_color) == 1){ on_color <- rep(on_color, number) }
  if(length(anim) == 1){ anim <- rep(anim, number) }
  if(length(duration) == 1){ duration <- rep(duration, number) }
  if(length(size) == 1){ size <- rep(size, number) }
  if(length(read_only) == 1){ read_only <- rep(read_only, number) }
  # lapply
  tag <- lapply(1: number,function(i){
    # definition of initial color
    if(i <= init_value & !is.na(init_value) & cumul == TRUE){ init_color <- on_color[i] }
    else if (i == init_value & !is.na(init_value) & cumul == FALSE) { init_color <- on_color[i] }
    else { init_color <- off_color[i] }
    # icon creation
    createIcon(
      id = paste0(rating_id,i),
      i_name = as.character(i_name[i]),
      i_lib = i_lib,
      i_number = i,
      number = number,
      rating_id = rating_id,
      on_color = on_color[i],
      off_color = off_color[i],
      init_color = init_color,
      size = size[i],
      anim = anim[i],
      duration = duration[i],
      cumul = cumul,
      tlp = tlp[i],
      tlp_msg = tlp_msg[i],
      tlp_position = tlp_position[i],
      tlp_color = tlp_color[i],
      read_only = read_only[i],
      hover = hover
    )
  })
  # margin adaptation
  tag <- div(class="m-0 mt-2 p-0", tag)
  # return
  return(tag)
}
