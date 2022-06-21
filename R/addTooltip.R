#' Add tooltip to an HTML element
#'
#' @param el Element for witch to add a tooltip.
#' @param tlp_color Tooltip Boostrap 5 color
#' @param tlp_msg Tooltip message
#' @param tlp_position Tooltip position
#'
#' @import htmltools
#' @import shiny
#' @return A html element with tooltip
#' @export
#' @example addTooltip(div("test"), tlp_msg = "test")

addTooltip <- function(el,
                        tlp_color = "black",
                        tlp_msg,
                        tlp_position = "top"
                        ) {

  # special case of black and white
  tlp_color_css <- ifelse(tlp_color == "black" | tlp_color == "white" ,
                          tlp_color,
                          sprintf("var(--bs-%s)",tlp_color)
  )
  # tooltip
  tooltip <- tagAppendAttributes(
    el,
    title = HTML(as.character(tlp_msg)),
    `data-bs-placement` = tlp_position,
    `data-bs-toggle` = "tooltip",
    `data-bs-html` = "true",
    `data-bs-trigger` = "hover focus",
    role ="button",
    tabindex = "0",
    `data-bs-custom-class` = sprintf("tooltip-%s",tlp_color)
  )
  # tooltip dependence
  tooltip_dep <- htmltools::htmlDependency(
    name = "tooltip",
    version = "0.0.1",
    package = "ShinyRating",
    src = "assets",
    script = "tooltip.js",
    stylesheet =  c(file = "tooltip.css")
  )
  # attach dependence
  tooltip <- tagList(tooltip_dep, tooltip)

  return(tooltip)

}
