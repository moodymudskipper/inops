#' Range operators
#'
#' @param x an object compatible with comparison operators
#' @param range an object compatible with `base::range()`, typically a numeric
#' vector of size 2 or more, or a list or data frame containing numeric elements.
#'
#' @examples
#' vec <- c(0, 3, 6 ,9, 12)
#' # given a range
#' vec %in[]% c(3, 9)
#' vec %in[)% c(3, 9)
#' vec %!in[]% c(3 ,9)
#' # range is applied on rhs so we can provide a longer or unsorted vector
#' vec %in[]% c(3,2,7,4)
#' # range works on data frames or lists as long as they contain only numeric elements
#' vec %in[]% iris[1:4]
#' # subset
#' vec %subset[]% c(2,7)
#' # replacement
#' vec %in[]% c(3, 7) <- 8
#' vec
#' vec %in[]% c(3, 10) <- min
#' vec
#' vec %in[]% c(-1,5) <- ~.+50
#' vec
#' @name range_ops
NULL


#####################################################################
# `%in()%` , `%in()<-%`, `%()%`, `%!in()%` , `%!in()<-%`, `%!()%`   #
#####################################################################

#' @rdname range_ops
#' @export
`%in()%` <- function(x, range){
  range <- range(range)
  x > range[1] & x < range[2]
}

#' @rdname range_ops
#' @export
`%in()%<-` <- function (x, range, value) {
  cond <- x %in()% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%subset()%` <- function(x, range) {
  x[x %in()% range]
}

#' @rdname range_ops
#' @export
`%!in()%` <- function(x, range){
  range <- range(range)
  !(x > range[1] & x < range[2])
}

#' @rdname range_ops
#' @export
`%!in()%<-` <- function (x, range, value) {
  cond <- x %!in()% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%!subset()%` <- function(x, range) {
  x[x %!in()% range]
}

#####################################################################
# `%in(]%` , `%in(]<-%`, `%(]%`, `%!in(]%` , `%!in(]<-%`, `%!(]%`   #
#####################################################################

#' @rdname range_ops
#' @export
`%in(]%` <- function(x, range){
  range <- range(range)
  x >= range[1] & x <= range[2]
}

#' @rdname range_ops
#' @export
`%in(]%<-` <- function (x, range, value) {
  cond <- x %in(]% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%subset(]%` <- function(x, range) {
  x[x %in(]% range]
}

#' @rdname range_ops
#' @export
`%!in(]%` <- function(x, range){
  range <- range(range)
  !(x >= range[1] & x <= range[2])
}

#' @rdname range_ops
#' @export
`%!in(]%<-` <- function (x, range, value) {
  cond <- x %!in(]% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%!subset(]%` <- function(x, range) {
  x[x %!in(]% range]
}


#####################################################################
# `%in[)%` , `%in[)<-%`, `%[)%`, `%!in[)%` , `%!in[)<-%`, `%![)%`   #
#####################################################################

#' @rdname range_ops
#' @export
`%in[)%` <- function(x, range){
  range <- range(range)
  x >= range[1] & x <= range[2]
}

#' @rdname range_ops
#' @export
`%in[)%<-` <- function (x, range, value) {
  cond <- x %in[)% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%subset[)%` <- function(x, range) {
  x[x %in[)% range]
}

#' @rdname range_ops
#' @export
`%!in[)%` <- function(x, range){
  range <- range(range)
  !(x >= range[1] & x <= range[2])
}

#' @rdname range_ops
#' @export
`%!in[)%<-` <- function (x, range, value) {
  cond <- x %!in[)% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%!subset[)%` <- function(x, range) {
  x[x %!in[)% range]
}


#####################################################################
# `%in[]%` , `%in[]<-%`, `%[]%`, `%!in[]%` , `%!in[]<-%`, `%![]%`   #
#####################################################################

#' @rdname range_ops
#' @export
`%in[]%` <- function(x, range){
  range <- range(range)
  x >= range[1] & x <= range[2]
}

#' @rdname range_ops
#' @export
`%in[]%<-` <- function (x, range, value) {
  cond <- x %in[]% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%subset[]%` <- function(x, range) {
  x[x %in[]% range]
}

#' @rdname range_ops
#' @export
`%!in[]%` <- function(x, range){
  range <- range(range)
  !(x >= range[1] & x <= range[2])
}

#' @rdname range_ops
#' @export
`%!in[]%<-` <- function (x, range, value) {
  cond <- x %!in[]% range
  if(any(cond)){
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(x[cond])
    replace(x, cond, value)
  } else x
}

#' @rdname range_ops
#' @export
`%!subset[]%` <- function(x, range) {
  x[x %!in[]% range]
}

