
#' load an svg file
#'
#' @param i_width svg width
#' @param i_height svg height
#' @param i_name svg path
#'
#' @importFrom xml2 read_xml xml_attrs xml_set_attrs
#' @return svg in tag
#' @export

read_icon <- function(i_name, i_width = "2em", i_height = NULL){

  if (is.null(i_height) == TRUE && is.null(i_width) == FALSE){
    style_svg <- sprintf("width:%s;fill:currentColor;stroke:currentColor;", i_width)
  }
  else if (is.null(i_height) == FALSE && is.null(i_width) == TRUE){
    style_svg <- sprintf("height:%s;fill:currentColor;stroke:currentColor;", i_height)
  }
  else {
    style_svg <- sprintf("height:%s;width:%s;fill:currentColor;stroke:currentColor;", i_height, i_width)
  }

  icon <- xml2::read_xml(i_name)
  attr <- xml2::xml_attrs(icon)
  xml2::xml_set_attrs(icon, NULL)
  xml2::xml_set_attrs(icon, c(
    attr[setdiff(names(attr), c("width", "height","fill","stroke"))],
    style = style_svg)
  )
  icon <- xml2tags(icon)
  icon
  return(icon)
}

#' transform xml into tags
#'
#' @param x xml
#' @importFrom htmltools tag tagAppendChildren
#' @importFrom xml2 xml_name xml_attrs xml_children
#' @return xml in tags
#' @export
#'

xml2tags <- function(x){
  out <- htmltools::tag(xml2::xml_name(x), varArgs = as.list(xml2::xml_attrs(x)))
  do.call(
    htmltools::tagAppendChildren,
    c(tag = list(out), Map(xml2tags, xml2::xml_children(x)))
  )
}

#essai = read_icon("C:/Users/mhanf/Downloads/doctor-hospital-medical-svgrepo-com.svg")
