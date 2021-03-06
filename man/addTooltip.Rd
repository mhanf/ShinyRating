% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/addTooltip.R
\name{addTooltip}
\alias{addTooltip}
\title{Add a tooltip to a \code{shiny.tag}}
\usage{
addTooltip(el, tlp_color = "black", tlp_msg, tlp_position = "top")
}
\arguments{
\item{el}{A \code{shiny.tag} object}

\item{tlp_color}{The tooltip color, \code{"primary"}, \code{"secondary"}, \code{"light"}, \code{"dark"}, \code{"info"}, \code{"warning"}, \code{"danger"}, \code{"success"}, \code{"white"}, or \code{"black"}.}

\item{tlp_msg}{The character string to be shown as message in the tooltip.}

\item{tlp_position}{The tooltip position, \code{"top"}, \code{"right"}, \code{"bottom"}, or \code{"left"}.}
}
\value{
A \code{shiny.tag} object with a tooltip.
}
\description{
Add a tooltip to a \code{shiny.tag}.
}
