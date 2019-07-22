#' Replacing Values and Intervals
#'
#' Operators for replacing values within a given interval or set.
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
#' Operations using numeric intervals are a convenient short hand form of\cr\code{x[x > interval[1] & x < interval[2]] <- value}.
#'
#' \code{interval} can be specified as a numeric vector of any length.
#' In such cases \code{range} will be used in order to obtain the endpoints.
#'
#' @param x vector or array of values to be matched.
#' @param table vector or list to be matched against.
#' @param interval numeric vector defining a range to be matched against.
#' @param value replacement value.
#'
#' @return \code{x} with specified values replaced with \code{value}.
#'
#' @seealso \code{\%in{}\%}
#' @name in_replace
NULL


#' @rdname in_replace
#' @export
`%in{}%<-` <- function(x, table, value) {
  in_replace(x, `%in{}%`, table, value)
}

#' @rdname in_replace
#' @export
`%!in{}%<-` <- function(x, table, value) {
  in_replace(x, `%!in{}%`, table, value)
}


#' @rdname in_replace
#' @export
`%in[]%<-` <- function(x, interval, value) {
  in_replace(x, `%in[]%`, interval, value)
}

#' @rdname in_replace
#' @export
`%!in[]%<-` <- function(x, interval, value) {
  in_replace(x, `%!in[]%`, interval, value)
}


#' @rdname in_replace
#' @export
`%in()%<-` <- function(x, interval, value) {
  in_replace(x, `%in()%`, interval, value)
}

#' @rdname in_replace
#' @export
`%!in()%<-` <- function(x, interval, value) {
  in_replace(x, `%!in()%`, interval, value)
}


#' @rdname in_replace
#' @export
`%in(]%<-` <- function(x, interval, value) {
  in_replace(x, `%in(]%`, interval, value)
}

#' @rdname in_replace
#' @export
`%!in(]%<-` <- function(x, interval, value) {
  in_replace(x, `%!in(]%`, interval, value)
}


#' @rdname in_replace
#' @export
`%in[)%<-` <- function(x, interval, value) {
  in_replace(x, `%in[)%`, interval, value)
}

#' @rdname in_replace
#' @export
`%!in[)%<-` <- function(x, interval, value) {
  in_replace(x, `%!in[)%`, interval, value)
}
