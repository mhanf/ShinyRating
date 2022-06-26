#' Create a icon rating
#'
#' @param rating_id Rating input control id
#' @param i_name Name of the icon.
#' @param i_lib The icon library to use. Either "font-awesome" or "glyphicon".
#' @param number Number of icons in rating input control.
#' @param init_value Initial value.
#' @param on_color Selection color of icons (hex or Boostrap 5 color)
#' @param off_color Default color of icons (hex or Boostrap 5 color)
#' @param size Size of the icons (1 to 5)
#' @param anim Type of animation from animate.css library (https://animate.style/)
#' @param duration Duration of the animation
#' @param tlp Tooltip for the icons (TRUE or FALSE)
#' @param tlp_msg Tooltip messages
#' @param tlp_position Tooltip positions
#' @param tlp_color Tooltip colors
#' @param cumul Cumulative color for icons (TRUE or FALSE)
#' @param read_only Read Only mode for icons (TRUE or FALSE)
#'
#' @import shiny
#' @return a icons rating
#' @export
#'
#' @examples
#' createRating(rating_id = "test")

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
                         cumul = TRUE,
                         tlp = FALSE,
                         tlp_msg = 1:number,
                         tlp_position = "top",
                         tlp_color = "black",
                         read_only = FALSE
){

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

  tag <- lapply(1: number,function(i){

    if(i <= init_value & !is.na(init_value) & cumul == TRUE){ init_color <- on_color[i] }
    else if (i == init_value & !is.na(init_value) & cumul == FALSE) { init_color <- on_color[i] }
    else { init_color <- off_color[i] }

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
      read_only = read_only[i]
    )
  })

  tag <- div(class="m-0 mt-2 p-0", tag)

  return(tag)

}
