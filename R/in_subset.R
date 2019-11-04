#' Subsetting Values and Intervals
#'
#' Operators for subsetting values within a given interval or set.
#'
#' For each `%[*%` operator of this package `x %[*% y` is a shorthand for
#' `x[x %*% y]`.
#'
#' @inheritParams in_detect
#'
#' @return `x` with specified values replaced with `value`.
#'
#' @examples
#' # interval subsetting operators
#' x <- 1:10
#' x %[in[]% c(3,7)
#' x %[in[)% c(3,7)
#' x %[out[)% c(3,7)
#'
#' # regular expression subsetting operators
#' carnames <- rownames(mtcars)
#' carnames %[in~% "^Mazda"
#' carnames %[in~% c("^Mazda", "^Merc")
#' carnames %[in~% c("\\w{10,100}$")  # long car names
#'
#' # count-based subsetting operators
#' mtcars$cyl %[in#% 1:10
#' mtcars$cyl %[out#% 1:10
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
`%[in~p%` <- function(x, pattern) {
  x[ x %in~p% pattern]
}

#' @rdname in_subset
#' @export
`%[out~p%` <- function(x, pattern) {
  x[ x %out~p% pattern]
}


#' @rdname in_subset
#' @export
`%[in~f%` <- function(x, pattern) {
  x[ x %in~f% pattern]
}

#' @rdname in_subset
#' @export
`%[out~f%` <- function(x, pattern) {
  x[ x %out~f% pattern]
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


#' @rdname in_subset
#' @export
`%[in#%` <- function(x, count) {
  if(is.data.frame(x)) {
    tb <- table(as.matrix(x))
  } else {
    tb <- table(x)
  }
  set <- names(tb[tb %in% count])
  x %[in% set
}

#' @rdname in_subset
#' @export
`%[out#%` <- function(x, count) {
  if(is.data.frame(x)) {
    tb <- table(as.matrix(x))
  } else {
    tb <- table(x)
  }
  set <- names(tb[tb %in% count])
  x %[out% set
}

