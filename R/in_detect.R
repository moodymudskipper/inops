#' Detect values that don't match
#'
#' `%out%` is the negation of `%in%`, so `x %out% y` is equivalent to `! x %in% y`.
#'
#' @param x vector of values to be matched.
#' @param table vector or list to be matched against.
#'
#' @return a logical vector or of the same length as `x`
#' indicating if each value of `x` is within the defined subset.
#'
#' @examples
#' iris$Species %in% c("setosa", "versicolor")
#' iris$Species %out% c("setosa", "versicolor")
#'
#' @seealso `%in%`
#'
#' @name out
#' @export
`%out%` <- function(x, table) {
  !x %in% table
}

#' Matching Values and Intervals
#'
#' Operators for detecting which values are within a given interval or set.
#'
#' Compared with default `%in%` implementation in R the operators implemented here try to be more consistent with other default infix operators like `==` and `<`.
#' In particular they preserve the dimensions and the missing values (see examples).
#'
#' Style of parentheses define the type of matching template:
#' * `%in{}%` detects which elements of `x` are present in the set given by the `table` argument.
#' * `%in()%`, `%in[]%`, `%in(]%` and `%in[)%` detect the elements of `x` included in a range of `interval` argument, using `range(interval)`.
#'   This range being closed, open on both sides, open on the left, or open on the right, respectively.
#' * `%in~%`, `%in~p%` and `%in~f%` detect the elements of `x` that match the regular expression given by `pattern`.
#'   They wrap `grepl()` with the default parameters of `perl = TRUE`, and with `fixed = TRUE`, respectively.
#' * `%in#%` detects the elements that occur a specified number of times.
#
#' Operators of the form `%out<suffix>%` return the negation of `%in<suffix>%`
#'
#' @param x vector or array of values to be matched.
#' @param table vector or list to be matched against.
#' @param interval numeric vector defining a range to be matched against.
#' @param pattern pattern to be matched against.
#' @param count numeric vector defining counts for count-based selection.
#'
#' @return a logical vector or an array of the same dimensions as `x`
#' indicating if each value of `x` is within the defined subset.
#'
#' @examples
#' # difference in behaviour with dimensions when compared to %in%
#' iris[1:10,] %in% "setosa"
#' iris[1:10,] == "setosa"
#' iris[1:10,] %in{}% "setosa"
#'
#' # difference in behaviour with missing values when compared to %in%
#' x <- c(1,2,3,NA,4)
#' x %in% c(1,2,3)
#' x %in{}% c(1,2,3)
#'
#' # other interval oparators
#' x <- 1:10
#' x %in[]% c(3,7)
#' x %in()% c(3,7)
#' x %in(]% c(3,7)
#' x %in[)% c(3,7)
#' x %out[]% c(3,7)
#'
#' # when more than 2 numbers are provided for the interval - range is used
#' x <- 1:10
#' all.equal(x %in[]% c(2,4), x %in[]% c(2,3,4))
#' all.equal(x %in[]% c(2,4), x %in[]% range(c(2,3,4)))
#'
#' # matching according to regular expressions
#' iris$Species %in~% "^v"
#' iris$Species %in~f% "^v"
#' iris$Species %in~f% "versicolor"
#' iris$Species %in~f% c("versicolor", "virginica")
#'
#' # selecting by number of occurances
#' mtcars$gear %in#% 1:5
#' mtcars$gear %out#% 1:5
#'
#' @seealso `%in%`
#' @name in_detect
NULL


#' @rdname in_detect
#' @export
`%in{}%` <- function(x, table){
  if(is.language(table)) return(x == table)
  Reduce(`|`, lapply(unique(table), `==`, x))
}

#' @rdname in_detect
#' @export
`%out{}%` <- function(x, table) {
  !(x %in{}% table)
}


#' @rdname in_detect
#' @export
`%in[]%` <- function(x, interval) {
  # fail on nested lists
  if (is.list(interval)) interval <- as.numeric(interval)
  interval <- range(interval, na.rm = TRUE)
  x >= interval[1] & x <= interval[2]
}

#' @rdname in_detect
#' @export
`%out[]%` <- function(x, interval) {
  !(x %in[]% interval)
}


#' @rdname in_detect
#' @export
`%in()%` <- function(x, interval) {
  # fail on nested lists
  if (is.list(interval)) interval <- as.numeric(interval)
  interval <- range(interval, na.rm = TRUE)
  x > interval[1] & x < interval[2]
}

#' @rdname in_detect
#' @export
`%out()%` <- function(x, interval) {
  !(x %in()% interval)
}


#' @rdname in_detect
#' @export
`%in(]%` <- function(x, interval) {
  # fail on nested lists
  if (is.list(interval)) interval <- as.numeric(interval)
  interval <- range(interval, na.rm = TRUE)
  x > interval[1] & x <= interval[2]
}

#' @rdname in_detect
#' @export
`%out(]%` <- function(x, interval) {
  !(x %in(]% interval)
}


#' @rdname in_detect
#' @export
`%in[)%` <- function(x, interval) {
  # fail on nested lists
  if (is.list(interval)) interval <- as.numeric(interval)
  interval <- range(interval, na.rm = TRUE)
  x >= interval[1] & x < interval[2]
}

#' @rdname in_detect
#' @export
`%out[)%` <- function(x, interval) {
  !(x %in[)% interval)
}


in_regex <- function(x , pattern, ...) {
  pattern <- unique(unlist(pattern))
  # convert to character
  if (is.factor(x)) {
    x <- levels(x)[x]
  }
  if (is.matrix(x) || is.data.frame(x)) {
    Reduce(`|`, lapply(pattern, function(y, x, ...) apply(x, 2, grepl, pattern = y), x, ...))
  } else {
    # conversion from list to character is done automatically by `==`
    # so we implement it as well here
    if (is.list(x) && !is.data.frame(x))
      x <- as.character(x)
    Reduce(`|`, lapply(pattern, grepl, x, ...))
  }
}

#' @rdname in_detect
#' @export
`%in~%` <- function(x , pattern) {
  in_regex(x, pattern)
}

#' @rdname in_detect
#' @export
`%out~%` <- function(x, pattern) {
  !x %in~% pattern
}


#' @rdname in_detect
#' @export
`%in~p%` <- function(x , pattern) {
  in_regex(x, pattern, perl = TRUE)
}

#' @rdname in_detect
#' @export
`%out~p%` <- function(x, pattern) {
  !x %in~p% pattern
}


#' @rdname in_detect
#' @export
`%in~f%` <- function(x , pattern) {
  in_regex(x, pattern, fixed = TRUE)
}

#' @rdname in_detect
#' @export
`%out~f%` <- function(x, pattern) {
  !x %in~p% pattern
}


#' @rdname in_detect
#' @export
`%in#%` <- function(x, count) {
  if(is.data.frame(x)) {
    x <- as.matrix(x)
  }
  ns <- stats::ave(as.numeric(factor(x)), x, FUN=length)
  dim(ns) <- dim(x)
  ns %in{}% count
}

#' @rdname in_detect
#' @export
`%out#%` <- function(x, count) {
  if(is.data.frame(x)) {
    x <- as.matrix(x)
  }
  ns <- stats::ave(as.numeric(factor(x)), x, FUN=length)
  dim(ns) <- dim(x)
  ns %out{}% count
}

