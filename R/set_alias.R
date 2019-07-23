#' Infix Set Aliases
#'
#' Alternative infix forms for set operations.
#'
#' @inheritParams base::setdiff
#'
#' @return Same result as the corresponding set operation implemented in R.
#'
#' @seealso \code{intersect}, \code{union}, \code{setdiff}, \code{setequal}
#' @name set_alias
NULL

#' @rdname set_alias
#' @export

`%intersect%` <- intersect
#' @rdname set_alias
#' @export
`%setdiff%` <- setdiff

#' @rdname set_alias
#' @export
`%union%` <- union

#' @rdname set_alias
#' @export
`%setequal%` <- setequal
