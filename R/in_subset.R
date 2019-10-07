#' Subsetting Values and Intervals
#'
#' Operators for replacing values within a given interval or set.
#'
#' For each `%[*%` operator of this package `x %[*% y` is a shorthand for
#' `x[x %*% y]`.
#'
#' @inheritParams in_check
#'
#' @return `x` with specified values replaced with `value`.
#'
#' @seealso `%in{}%`
#' @name in_subset
NULL


#' @rdname in_subset
#' @export
`%[in{}%` <- function(x, table) {
  x[ x %in{}% table]
}

#' @rdname in_subset
#' @export
`%[out{}%` <- function(x, table) {
  x[ x %out{}% table]
}


#' @rdname in_subset
#' @export
`%[in[]%` <- function(x, interval) {
  x[ x %in[]% interval]
}

#' @rdname in_subset
#' @export
`%[out[]%` <- function(x, interval) {
  x[ x %out[]% interval]
}


#' @rdname in_subset
#' @export
`%[in()%` <- function(x, interval) {
  x[ x %in()% interval]
}

#' @rdname in_subset
#' @export
`%[out()%` <- function(x, interval) {
  x[ x %out()% interval]
}


#' @rdname in_subset
#' @export
`%[in(]%` <- function(x, interval) {
  x[ x %in(]% interval]
}

#' @rdname in_subset
#' @export
`%[out(]%` <- function(x, interval) {
  x[ x %out(]% interval]
}


#' @rdname in_subset
#' @usage x \%in[)\% interval <- value
#' @export
`%[in[)%` <- function(x, interval) {
  x[ x %in[)% interval]
}

#' @rdname in_subset
#' @export
`%[out[)%` <- function(x, interval) {
  x[ x %out[)% interval]
}

#' @rdname in_subset
#' @export
`%[in~%` <- function(x, pattern) {
  x[ x %in~% pattern]
}

#' @rdname in_subset
#' @export
`%[out~%` <- function(x, pattern) {
  x[ x %out~% pattern]
}

#' @rdname in_subset
#' @export
`%[in%` <- function(x, table) {
  x[x %in% table]
}

#' @rdname in_subset
#' @export
`%[out%` <- function(x, table) {
  x[x %out% table]
}
