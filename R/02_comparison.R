#' Comparison Operators
#'
#'
#'
#' @param e1 lhs
#' @param e2 rhs
#' @param value replacement value
#'
#' @name comparison_ops
NULL

#' @rdname comparison_ops
#' @export
`>=<-` <- function(e1, e2, value){
  cond <- e1 >= e2
  if(any(cond)) {
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(e1[cond])
    replace(e1, cond, value)
  } else e1
}

#' @rdname comparison_ops
#' @export
`><-` <- function(e1, e2, value){
  cond <- e1 > e2
  if(any(cond)) {
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(e1[cond])
    replace(e1, cond, value)
  } else e1
}

#' @rdname comparison_ops
#' @export
`<=<-` <- function(e1, e2, value){
  cond <- e1 <= e2
  if(any(cond)) {
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(e1[cond])
    replace(e1, cond, value)
  } else e1
}

#' @rdname comparison_ops
#' @export
`<<-` <- function(e1, e2, value){
  # this one needs extra care so standard base::`<<-` still works
  if (missing(value))
    eval.parent(substitute(.Primitive("<<-")(e1, e2)))
  else {
    cond <- e1 < e2
    if(any(cond)) {
      if(inherits(value,"formula")) {
        if (requireNamespace("rlang")) value <- rlang::as_function(value)
        else stop("install package rlang to use `%in<-` with formula notation")
      }
      if(is.function(value)) value <- value(e1[cond])
      replace(e1, cond, value)
    } else e1
  }
}

#' @rdname comparison_ops
#' @export
`==<-` <- function(e1, e2, value){
  cond <- e1 == e2
  if(any(cond)) {
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(e1[cond])
    replace(e1, cond, value)
  } else e1
}

#' @rdname comparison_ops
#' @export
`!=<-` <- function(e1, e2, value){
  cond <- e1 != e2
  if(any(cond)) {
    if(inherits(value,"formula")) {
      if (requireNamespace("rlang")) value <- rlang::as_function(value)
      else stop("install package rlang to use `%in<-` with formula notation")
    }
    if(is.function(value)) value <- value(e1[cond])
    replace(e1, cond, value)
  } else e1
}

#' @rdname comparison_ops
#' @export
`%subset>=%` <- function(e1, e2) e1[e1 >= e2]

#' @rdname comparison_ops
#' @export
`%subset>%`  <- function(e1, e2) e1[e1 > e2]

#' @rdname comparison_ops
#' @export
`%subset<=%` <- function(e1, e2) e1[e1 <= e2]

#' @rdname comparison_ops
#' @export
`%subset<%`  <- function(e1, e2) e1[e1 < e2]

#' @rdname comparison_ops
#' @export
`%subset==%` <- function(e1, e2) e1[e1 == e2]

#' @rdname comparison_ops
#' @export
`%subset!=%` <- function(e1, e2) e1[e1 != e2]

# vec <- c(0, 3, 6 ,9)
# vec >= 5 <- 10
# vec
# #> [1]  0  3 10 10
# vec == 10 <- ~.*7
# vec
# #> [1]  0  3 70 70
# # no value above 1000, so no stop
# vec >= 1000 <- ~ stop()
# # stops if condition verified
# vec >= 5 <- ~ stop("found value superior to 5!")
# #> Error in value(e1[cond]): found value superior to 5!
# vec %v>=% 3
# #> [1]  3 70 70
# vec %v==% 70
# #> [1] 70 70
