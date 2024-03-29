#' Add a tooltip to a \code{shiny.tag}
#' @description Add a tooltip to a \code{shiny.tag}.
#' @param el A \code{shiny.tag} object
#' @param tlp_color The tooltip color, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.
#' @param tlp_msg The character string to be shown as message.
#' @param tlp_position The tooltip position, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.
#' @importFrom htmltools htmlDependency
#' @import shiny
#' @return A \code{shiny.tag} object with a tooltip.
#' @noRd
#' @examples
#' addTooltip(
#'   div("test"),
#'   tlp_msg = "test"
#' )
#'
addTooltip <- function(el,
                       tlp_color = "black",
                       tlp_msg,
                       tlp_position = "top") {
  # special case of black and white
  tlp_color_css <- ifelse(
    tlp_color == "black" | tlp_color == "white",
    tlp_color,
    sprintf("var(--bs-%s)", tlp_color)
  )
  # tooltip
  tooltip <- tagAppendAttributes(
    el,
    title = HTML(as.character(tlp_msg)),
    `data-bs-placement` = tlp_position,
    `data-bs-toggle` = "tooltip",
    `data-bs-html` = "true",
    `data-bs-trigger` = "hover focus",
    role = "button",
    tabindex = "0",
    `data-bs-custom-class` = sprintf("tooltip-%s", tlp_color)
  )
  # tooltip dependence
  tooltip_dep <- htmltools::htmlDependency(
    name = "tooltip",
    version = "0.0.1",
    package = "ShinyRating",
    src = "assets",
    script = "tooltip.js",
    stylesheet = c(file = "tooltip.css")
  )
  # attach dependence
  tooltip <- tagList(tooltip_dep, tooltip)
  # return
  return(tooltip)
}
