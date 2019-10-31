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
#' @seealso `%in%`
#'
#' @export
`%out%` <- function(x, table) {
  !x %in% table
}

#' Matching Values and Intervals
#'
#' Operators for checking which values are within a given interval or set.
#'
#' Parentheses of each operator define the type of matching template:
#' * `%in{}%` detects the elements of x found in the set of all given by the `table`
#'   argument. It is a reimplementation of `%in%` that behaves more
#'   consistently to equality and comparison operators. Like the latter, and
#'   like the other operators described here it preserves the dimensions of `x`
#'   and the missing values.
#' * `%in()%`, `%in[]%`, `%in(]%` and `%in[)%` detect the elements of x included in
#'   a range computed from the `interval` argument,using `range(interval)`, this range being
#'   respectively closed, open, open on the left and closed on the right, or
#'   closed on the left and open on the right
#' * `%in~%`, `%in~p%` and `%in~f%` detect the elements of x which match the
#'   regular expression given by `pattern`, they wrap `grepl()` respectively
#'   with default parameters, with `perl = TRUE`, and with `fixed = TRUE`
#
#' Operators of the form `%out<suffix>%` return the negation of `%in<suffix>%`
#'
#' @param x vector or array of values to be matched.
#' @param table vector or list to be matched against.
#' @param interval numeric vector defining a range to be matched against.
#' `as.numeric()` is used on lists, it will succeed on flat lists but fail on
#' nested lists
#' @param pattern pattern to be matched against.
#' @param value replacement value.
#'
#' @return a logical vector or an array of the same dimensions as `x`
#' indicating if each value of `x` is within the defined subset.
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

# previous impl
# `%in{}%` <- function(x, table) {
#   table <- unlist(table)
#   # the lhs must be coercible to an atomic type if it's a list
#   if (is.list(x) && !is.data.frame(x)) {
#     x <- switch(
#       typeof(table),
#       logical = as.logical(x),
#       integer = as.integer(x),
#       double = as.double(x),
#       complex = as.complex(x),
#       character = as.character(x),
#       raw = as.raw(x),
#       x)
#   }
#
#   # convert to character
#   if (is.factor(table)) {
#     table <- levels(table)[table]
#   }
#   if (is.data.frame(x)){
#     res <- sapply(x, `%in%`, table)
#   } else if (is.matrix(x)){
#     res <- apply(x, 2, `%in%`, table)
#   } else if (is.atomic(x)) {
#     if(is.language(table))
#       res <- x == table
#     else
#       res <- x %in% table
#   } else {
#     if(is.language(x)){
#       if(is.language(table))
#         res <- x == table
#       else
#         res <- any(sapply(table, function(a,b)
#           if(is.language(a)) a == b else a %in% b, x))
#     }else
#       res <- sapply(x, function(a,b)
#         if(is.language(a)) any(a == b) else a %in% b, table)
#   }
#
#   if (!is.language(x)) res[is.na(x)] <- NA
#   res
# }

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
