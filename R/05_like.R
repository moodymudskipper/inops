#' like variants
#'
#' @inheritParams base::match
#' @param x character or factor vector
#' @param pattern pattern to be matched
#' @param value replacement value
#'
#' @name like_variants
NULL

#' @rdname like_variants
#' @export
`%like%` <- function(x , pattern) {
  if (is.factor(x)) {
    as.integer(x) %in% grep(pattern, levels(x))
  }
  else {
    grepl(pattern, x)
  }
}

#' @rdname like_variants
#' @export
`%like%<-` <- function (x, pattern, value) {
  if(is.factor(x)){
    # if factor we replace levels not values
    lvls <- levels(x)
    cond <- lvls %like% pattern
    if(any(cond)){
      # if value is function we apply it on relevant subset
      if(inherits(value,"formula")) {
        if (requireNamespace("rlang")) value <- rlang::as_function(value)
        else stop("install package rlang to use `%in<-` with formula notation")
      }
      if(is.function(value)) value <- value(lvls[cond])
      # replace relevant levels
      levels(x)[cond] <- value
    }
  } else {
    cond <- x %like% pattern
    if(any(cond)){
      # if value is function we apply it on relevant subset
      if(inherits(value,"formula")) {
        if (requireNamespace("rlang")) value <- rlang::as_function(value)
        else stop("install package rlang to use `%in<-` with formula notation")
      }
      if(is.function(value)) value <- value(x[cond])
      # replace relevant elements
      x <- replace(x, cond, value)
    }
  }
  x
}

#' @rdname like_variants
#' @export
`%!like%` <- function(x, pattern) !x %like% pattern

# copy and paste from `%like%`, adding `!` to `cond` definition
#' @rdname like_variants
#' @export
`%!like%<-` <- function (x, pattern, value) {
  if(is.factor(x)){
    # if factor we replace levels not values
    lvls <- levels(x)
    cond <- !lvls %like% pattern
    if(any(cond)){
      # if value is function we apply it on relevant subset
      if(inherits(value,"formula")) {
        if (requireNamespace("rlang")) value <- rlang::as_function(value)
        else stop("install package rlang to use `%in<-` with formula notation")
      }
      if(is.function(value)) value <- value(lvls[cond])
      # replace relevant levels
      levels(x)[cond] <- value
    }
  } else {
    cond <- !x %like% pattern
    if(any(cond)){
      # if value is function we apply it on relevant subset
      if(inherits(value,"formula")) {
        if (requireNamespace("rlang")) value <- rlang::as_function(value)
        else stop("install package rlang to use `%in<-` with formula notation")
      }
      if(is.function(value)) value <- value(x[cond])
      # replace relevant elements
      x <- replace(x, cond, value)
    }
  }
  x
}
