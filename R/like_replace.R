#' Pattern Matching Replace Operators
#'
#' Infix operators for replacing values matched by a pattern.
#'
#' @param x an object where matches will be sought.
#' @param pattern character string containing regular expression to be matched.
#' @param value replacement value.
#'
#' @return \code{x} with pattern-matched values replaced with \code{value}.
#'
#' @seealso \code{\%like\%}, code{grepl}
#' @name like_replace
NULL

#' @rdname like_replace
#' @usage x %like% pattern <- value
#' @export
`%like%<-` <- function (x, pattern, value) {
  infix_replace(x, `%like%`, pattern, value)
}

# copy and paste from `%like%`, adding `!` to `cond` definition
#' @rdname like_replace
#' @usage x %!like% pattern <- value
#' @export
`%!like%<-` <- function (x, pattern, value) {
  infix_replace(x, `%!like%`, pattern, value)
}
