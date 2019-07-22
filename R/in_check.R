#' Matching Values and Intervals
#'
#' Operators for checking which values are within a given interval or set.
#'
#' Parentheses of each operator define the type of matching template:\cr
#' \code{\%in\{\}\%} - set of all elements that will be matched against\cr
#' \code{\%in[]\%} - closed numeric interval\cr
#' \code{\%in()\%} - open numeric interval\cr
#' \code{\%in(]\%} - interval that is is open on the left and closed on the right\cr
#' \code{\%in[)\%} - interval that is closed on the left and open on the right\cr
#
#' Operators starting with a bang (i.e. \code{\%!in\{\}\%}) specify negation.
#'
#' The \code{\%in\{\}\%} operator is a reimplementation of \code{\%in\%} that preserves the dimensions of \code{x} (see examples).
#' Operations using numeric intervals are a convenient short hand form of\cr\code{x > interval[1] & x < interval[2]}.
#'
#' \code{interval} can be specified as a numeric vector of any length.
#' In such cases \code{range} will be used in order to obtain the endpoints.
#'
#' @param x vector or array of values to be matched.
#' @param table vector or list to be matched against.
#' @param interval numeric vector defining a range to be matched against.
#'
#' @return a logical vector or an array of the same dimensions as \code{x}
#' indicating if each value of \code{x} is within the defined subset.
#'
#' @seealso \code{\%in\%}
#' @name in_check
NULL

#' @rdname in_check
#' @export
`%in{}%` <- function(x, table) {
  if (is.atomic(x)) {
    res <- x %in% table
  } else {
    res <- lapply(x, `%in%`, table)
  }
  attributes(res) <- attributes(x)
  res[is.na(x)] <- NA
  res
}

#' @rdname in_check
#' @export
`%!in{}%` <- function(x, table) {
  !(x %in{}% table)
}


#' @rdname in_check
#' @export
`%in[]%` <- function(x, interval) {
  interval <- range(interval, na.rm=TRUE)
  x >= interval[1] & x <= interval[2]
}

#' @rdname in_check
#' @export
`%!in[]%` <- function(x, interval) {
  !(x %in[]% interval)
}


#' @rdname in_check
#' @export
`%in()%` <- function(x, interval) {
  interval <- range(interval, na.rm=TRUE)
  x > interval[1] & x < interval[2]
}

#' @rdname in_check
#' @export
`%!in()%` <- function(x, interval) {
  !(x %in()% interval)
}


#' @rdname in_check
#' @export
`%in(]%` <- function(x, interval) {
  interval <- range(interval, na.rm=TRUE)
  x > interval[1] & x <= interval[2]
}

#' @rdname in_check
#' @export
`%!in(]%` <- function(x, interval) {
  !(x %in(]% interval)
}


#' @rdname in_check
#' @export
`%in[)%` <- function(x, interval) {
  interval <- range(interval, na.rm=TRUE)
  x >= interval[1] & x < interval[2]
}

#' @rdname in_check
#' @export
`%!in[)%` <- function(x, interval) {
  !(x %in[)% interval)
}

