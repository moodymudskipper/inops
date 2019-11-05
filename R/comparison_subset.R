#' Subsetting Values by Comparison
#'
#' Operators for subsetting values using the standard comparison operators.
#'
#' @param x first element of the operation.
#' @param y second element of the operation.
#'
#' @return elements of `x` matched by the used comparison.
#'
#' @examples
#' ages <- c(130, 10, 21, 39, 74, -2, 0)
#' ages %[<% 5
#'
#' letters %[==% "a"
#'
#' letters %[!=% "a"
#'
#' @seealso \code{`==`}
#' @name comparison_subset
NULL

#' @rdname comparison_subset
#' @export
`%[>=%` <- function(x, y) {
  x[x >= y]
}

#' @rdname comparison_subset
#' @export
`%[>%` <- function(x, y) {
  x[x > y]
}

#' @rdname comparison_subset
#' @export
`%[<=%` <- function(x, y) {
  x[x <= y]
}

#' @rdname comparison_subset
#' @export
`%[<%` <- function(x, y) {
  x[x < y]
}

#' @rdname comparison_subset
#' @export
`%[==%` <- function(x, y) {
  x[x == y]
}

#' @rdname comparison_subset
#' @export
`%[!=%` <- function(x, y) {
  x[x != y]
}

