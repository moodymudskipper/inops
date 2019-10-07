#' Replacing Values by Comparison
#'
#' Operators for replacing values using the standard comparison operators.
#'
#' Thanks to these operators :
#' * `x == y <- value` is equivalent to `x[x == y] <- value`
#' * `x == y <- value` is equivalent to `x[x == y] <- value`
#' * `x == y <- value` is equivalent to `x[x == y] <- value`
#' * `x == y <- value` is equivalent to `x[x == y] <- value`
#'
#' @param x first element of the operation.
#' @param y second element of the operation.
#' @param value replacement value.
#'
#' @return \code{x} with values for which the comparisons evaluate to TRUE replaced with \code{value}.
#'
#' @seealso \code{`==`}
#' @name comparison_replace
NULL

#' @rdname comparison_replace
#' @usage x >= y <- value
#' @export
`>=<-` <- function(x, y, value){
  replace(x, x >= y, value)
}

#' @rdname comparison_replace
#' @usage x > y <- value
#' @export
`><-` <- function(x, y, value){
  replace(x, x > y, value)
}

#' @rdname comparison_replace
#' @usage x <= y <- value
#' @export
`<=<-` <- function(x, y, value){
  replace(x, x <= y, value)
}

#' @rdname comparison_replace
#' @usage x < y <- value
#' @export
`<<-` <- function(x, y, value){
  # this one needs extra care so standard base::`<<-` still works
  if (missing(value)) {
    eval.parent(substitute(.Primitive("<<-")(x, y)))
  } else {
    replace(x, x < y, value)
  }
}

#' @rdname comparison_replace
#' @usage x == y <- value
#' @export
`==<-` <- function(x, y, value){
  replace(x, x == y, value)
}

#' @rdname comparison_replace
#' @usage x != y <- value
#' @export
`!=<-` <- function(x, y, value){
  replace(x, x != y, value)
}

