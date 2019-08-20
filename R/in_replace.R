#' Replacing Values and Intervals
#'
#' Operators for replacing values within a given interval or set.
#'
#' @inheritParams in_check
#' @param value replacement value.
#'
#' @return `x` with specified values replaced with `value`.
#'
#' @seealso `%in{}%`
#' @name in_replace
NULL


#' @rdname in_replace
#' @usage x \%in{}\% table <- value
#' @export
`%in{}%<-` <- function(x, table, value) {
  replace(x, x %in{}% table, value)
}

#' @rdname in_replace
#' @usage x \%out{}\% table <- value
#' @export
`%out{}%<-` <- function(x, table, value) {
  replace(x, x %out{}% table, value)
}


#' @rdname in_replace
#' @usage x \%in[]\% interval <- value
#' @export
`%in[]%<-` <- function(x, interval, value) {
  replace(x, x %in[]% interval, value)
}

#' @rdname in_replace
#' @usage x \%out[]\% interval <- value
#' @export
`%out[]%<-` <- function(x, interval, value) {
  replace(x, x %out[]% interval, value)
}


#' @rdname in_replace
#' @usage x \%in()\% interval <- value
#' @export
`%in()%<-` <- function(x, interval, value) {
  replace(x, x %in()% interval, value)
}

#' @rdname in_replace
#' @usage x \%out()\% interval <- value
#' @export
`%out()%<-` <- function(x, interval, value) {
  replace(x, x %out()% interval, value)
}


#' @rdname in_replace
#' @usage x \%in(]\% interval <- value
#' @export
`%in(]%<-` <- function(x, interval, value) {
  replace(x, x %in(]% interval, value)
}

#' @rdname in_replace
#' @usage x \%out(]\% interval <- value
#' @export
`%out(]%<-` <- function(x, interval, value) {
  replace(x, x %out(]% interval, value)
}


#' @rdname in_replace
#' @usage x \%in[)\% interval <- value
#' @export
`%in[)%<-` <- function(x, interval, value) {
  replace(x, x %in[)% interval, value)
}

#' @rdname in_replace
#' @usage x \%out[)\% interval <- value
#' @export
`%out[)%<-` <- function(x, interval, value) {
  replace(x, x %out[)% interval, value)
}


#' @rdname in_replace
#' @usage x \%in~\% pattern <- value
#' @export
`%in~%<-` <- function(x, pattern, value) {
  replace(x, x %in~% pattern, value)
}

#' @rdname in_replace
#' @usage x \%out~\% pattern <- value
#' @export
`%out~%<-` <- function(x, pattern, value) {
  replace(x, x %out~% pattern, value)
}
