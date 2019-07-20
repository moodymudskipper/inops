#' Element wise in
#'
#' @inheritParams base::match
#' @param value replacement value
#'
#' @name element_wise_in
NULL

#' @rdname element_wise_in
#' @export
`%in{}%` <- function(x, table) {
  if (is.atomic(x)) {
    x %in% table
  } else {
    x[] <- lapply(x, `%in%`, table)
    x
  }
}

#' @rdname element_wise_in
#' @export
`%in{}%<-` <- function(x, table, value) {
  if (is.atomic(x)) {
    x %in% table <- value
    x
  } else {
    x[] <- lapply(x, `%in%<-`, table, value = value)
    x
  }
}

#' @rdname element_wise_in
#' @export
`%subset{}%` <- function(x, table) {
  if (is.atomic(x)) {
    x[x %in% table]
  } else {
    x <- lapply(x, intersect, table)
    x
  }
}

# negative copy and paste

#' @rdname element_wise_in
#' @export
`%!in{}%` <- function(x, table) {
  if (is.atomic(x)) {
    x %!in% table
  } else {
    x[] <- lapply(x, `%!in%`, table)
    x
  }
}

#' @rdname element_wise_in
#' @export
`%!in{}%<-` <- function(x, table, value) {
  if (is.atomic(x)) {
    x %!in% table <- value
    x
  } else {
    x[] <- lapply(x, `%!in%<-`, table, value = value)
    x
  }
}

#' @rdname element_wise_in
#' @export
`%!subset{}%` <- function(x, table) {
  if (is.atomic(x)) {
    x[x %!in% table]
  } else {
    x <- lapply(x, intersect, table)
    x
  }
}

# head(iris) %in{}% "setosa"
# #>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# #> 1        FALSE       FALSE        FALSE       FALSE    TRUE
# #> 2        FALSE       FALSE        FALSE       FALSE    TRUE
# #> 3        FALSE       FALSE        FALSE       FALSE    TRUE
# #> 4        FALSE       FALSE        FALSE       FALSE    TRUE
# #> 5        FALSE       FALSE        FALSE       FALSE    TRUE
# #> 6        FALSE       FALSE        FALSE       FALSE    TRUE
# iris2 <- iris
# iris2 %in{}% "setosa" <- "SETOSA"
# levels(iris2$Species)
# #> [1] "SETOSA"     "versicolor" "virginica"
# iris2 %in{}% c("versicolor", "virginica") <- c("VERSICOLOR", "VIRGINICA")
# levels(iris2$Species)
# #> [1] "SETOSA"     "VERSICOLOR" "VIRGINICA"
# iris2 %in{}% c("VERSICOLOR", "VIRGINICA") <- "V"
# iris2 %in{}% "SETOSA" <- tolower
# iris %{}% "setosa"
# #> $Sepal.Length
# #> character(0)
# #>
# #> $Sepal.Width
# #> character(0)
# #>
# #> $Petal.Length
# #> character(0)
# #>
# #> $Petal.Width
# #> character(0)
# #>
# #> $Species
# #> [1] "setosa"
# iris2 <- iris
# iris2 %!in{}% "setosa" <- toupper
# levels(iris2$Species)
# #> [1] "setosa"     "VERSICOLOR" "VIRGINICA"
