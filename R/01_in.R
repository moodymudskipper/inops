#' in variants
#'
#' @inheritParams base::match
#' @param value replacement value
#'
#' @name in_variants
NULL

#' @rdname in_variants
#' @export
`%in%<-` <- function (x, table, value) {
  if(is.factor(x)){
    # if factor we replace levels not values
    lvls <- levels(x)
    cond <- lvls %in% table
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
    cond <- x %in% table
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

#' @rdname in_variants
#' @export
`%!in%` <- function(x, table) !x %in% table

# copy and paste from `%in%`, adding `!` to `cond` definition
#' @rdname in_variants
#' @export
`%!in%<-` <- function (x, table, value) {
  if(is.factor(x)){
    # if factor we replace levels not values
    lvls <- levels(x)
    cond <- !lvls %in% table
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
    cond <- !x %in% table
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

# vec <- c(0, 10, 100 ,1000)
# vec %in% 5:500 <- 42
# vec
# #> [1]    0   42   42 1000
# vec %in% 42 <- c(10, 100)
# vec
# #> [1]    0   10  100 1000
# vec %!in% 5:100 <- 42
# vec
# #> [1]  42  10 100  42
# vec <- letters[1:4]
# vec %in% c("a","c") <- toupper
# vec
# #> [1] "A" "b" "C" "d"
# vec %in% c("A","C") <- ~paste0(.,"!!!")
# #> Loading required namespace: rlang
# vec
# #> [1] "A!!!" "b"    "C!!!" "d"

