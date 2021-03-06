#' Test if a text is a hex color
#' @param x text
#' @return logical,TRUE or FALSE

isHex <- function(x) {
  grepl("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", x)
}

#' Test if a vector has a length == 1 or equal to a given number
#' @param number Desired number of values
#' @param x Vector of values
#'
#' @return An error if the vector has a length != 1 and different to a given number
test_length <- function(x, number) {
  if ((length(x) > 1 & length(x) != number) | length(x) == 0) {
    stop(
      sprintf(
        "%s length must be 1 or equal to the number parameter: %s",
        deparse(substitute(x)),
        number
      )
    )
  }
}

#' Test if a vector of values is null
#' @param x Vector of values
#' @return An error if the vector is null
test_null <- function(x) {
  if (TRUE %in% is.null(x)) {
    stop(
      sprintf("%s must not be null", deparse(substitute(x)))
    )
  }
}

#' Test if values in a vector are NA
#' @param x Vector of values
#' @return An error if at least one value is NA
test_na <- function(x) {
  if (TRUE %in% is.na(x)) {
    stop(
      sprintf("%s must not be na", deparse(substitute(x)))
    )
  }
}

#' Test if values in a vector are a string
#' @param x Vector of values
#' @return An error if at least one value is not a string
test_character <- function(x) {
  if (FALSE %in% is.character(x) == TRUE) {
    stop(
      sprintf("%s must be a string", deparse(substitute(x)))
    )
  }
}

#' Test if values in a vector are logical
#' @param x Vector of values
#' @return An error if at least one value is not logical
test_logical <- function(x) {
  if (FALSE %in% is.logical(x) == TRUE) {
    stop(
      sprintf("%s must be logical", deparse(substitute(x)))
    )
  }
}

#' Test if values in a vector are positive integers
#' @param x Vector of values
#' @param na_rm Logical, are NA be removed ?
#' @return An error if at least one value is not an integer
test_pos_integer <- function(x, na_rm = FALSE) {
  # test na in x
  if ((TRUE %in% is.na(x)) & na_rm == FALSE) {
    stop(
      sprintf(
        "ShinyRating Error: %s parameter must not be NA",
        deparse(substitute(x))
      )
    )
  }
  # name x
  var <- deparse(substitute(x))
  # supress na in x
  x <- x[!is.na(x)]
  # test integer in x
  if (length(x) > 0) {
    if ((TRUE %in% is.na(as.numeric(x)))) {
      stop(
        sprintf(
          "ShinyRating Error: %s parameter must be integer",
          var
        )
      )
    } else if (as.integer(x) != x) {
      stop(
        sprintf(
          "ShinyRating Error: %s parameter must be integer",
          var
        )
      )
    } else if (TRUE %in% (x < 0)) {
      stop(
        sprintf(
          "ShinyRating Error: %s parameter must be > 0",
          var
        )
      )
    }
  }
}
