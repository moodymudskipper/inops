#' Pattern Matching Operators
#'
#' Infix operators for pattern matching.
#'
#' @param x an object where matches will be sought.
#' @param pattern character string containing regular expression to be matched.
#'
#' @return a logical vector or an array of the same dimensions as \code{x}
#' indicating if each value of \code{x} matched the provided pattern.
#'
#' @seealso \code{grepl}
#' @name like_check
NULL

#' @rdname like_check
#' @export
`%like%` <- function(x , pattern) {
  if(is.atomic(x)) {
    res <- grepl(pattern, x)
  } else {
    res <- Map(grepl, list(pattern), x)
  }
  attributes(res) <- attributes(x)
  res[is.na(x)] <- NA
  simplify2array(res)
}

#' @rdname like_check
#' @export
`%!like%` <- function(x, pattern) {
  !x %like% pattern
}
