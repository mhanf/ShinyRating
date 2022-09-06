
#' Load an svg file
#'
#' @param i_width svg width
#' @param i_height svg height
#' @param i_name svg path
#' @param i_margin_left,i_margin_right The length value for the margin that's either
#' left or right of the icon. By default, \code{"auto"} is used for both
#' properties. If space is needed on either side then a length of \code{"0.2em"} is
#' recommended as a starting point.
#' @importFrom xml2 read_xml xml_attrs xml_set_attrs
#' @return svg in tag
#' @noRd

read_icon <- function(i_name,
                      i_width = "2em",
                      i_height = NULL,
                      i_margin_left = "auto",
                      i_margin_right = "auto") {
  style_svg <- sprintf("fill:currentColor; stroke:currentColor; display:inline-block; margin-left:%s; margin-right:%s;", i_margin_left, i_margin_right)

  if (is.null(i_height) == TRUE && is.null(i_width) == FALSE) {
    style_svg <- sprintf("width:%s; %s", i_width, style_svg)
  } else if (is.null(i_height) == FALSE && is.null(i_width) == TRUE) {
    style_svg <- sprintf("height:%s; %s", i_height, style_svg)
  } else {
    style_svg <- sprintf("height:%s; width:%s; %s", i_height, i_width, style_svg)
  }

  icon <- xml2::read_xml(i_name)
  attr <- xml2::xml_attrs(icon)
  xml2::xml_set_attrs(icon, NULL)
  xml2::xml_set_attrs(icon, c(
    attr[setdiff(names(attr), c("width", "height", "fill", "stroke", "display"))],
    style = style_svg
  ))
  icon <- xml2tags(icon)
  icon
  return(icon)
}

#' Transform xml into tags
#'
#' @param x xml
#' @importFrom htmltools tag tagAppendChildren
#' @importFrom xml2 xml_name xml_attrs xml_children
#' @return xml in tags
#' @noRd

xml2tags <- function(x) {
  out <- htmltools::tag(xml2::xml_name(x), varArgs = as.list(xml2::xml_attrs(x)))
  do.call(
    htmltools::tagAppendChildren,
    c(tag = list(out), Map(xml2tags, xml2::xml_children(x)))
  )
}

# essai = read_icon("C:/Users/mhanf/Downloads/298963_fighter_rebel_x-wing_icon.svg")
