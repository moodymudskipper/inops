#' Replacing Values and Intervals
#'
#' Operators for replacing values within a given interval or set.
#'
#' For each `%*%<-` operator of this package `x %*% y <- value` is a shorthand for
#' `x[x %*% y] <- value`.
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

#' @rdname in_replace
#' @usage x \%in~f\% pattern <- value
#' @export
`%in~f%<-` <- function(x, pattern, value) {
  replace(x, x %in~f% pattern, value)
}

#' @rdname in_replace
#' @usage x \%out~f\% pattern <- value
#' @export
`%out~f%<-` <- function(x, pattern, value) {
  replace(x, x %out~f% pattern, value)
}


#' @rdname in_replace
#' @usage x \%in~p\% pattern <- value
#' @export
`%in~p%<-` <- function(x, pattern, value) {
  replace(x, x %in~p% pattern, value)
}

#' @rdname in_replace
#' @usage x \%out~p\% pattern <- value
#' @export
`%out~p%<-` <- function(x, pattern, value) {
  replace(x, x %out~p% pattern, value)
}


#' @rdname in_replace
#' @usage x \%in\% table <- value
#' @export
`%in%<-`  <- function(x, table, value) {
  replace(x, x %in% table, value)
}


#' @rdname in_replace
#' @usage x \%out\% table <- value
#' @export
`%out%<-`  <- function(x, table, value) {
  replace(x, x %out% table, value)
}

