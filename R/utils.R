# helper function for performing replacements with infix operators
infix_replace <- function(x, fun, template, value) {
  if(is.factor(x)) {
    cond <- fun(levels(x), template)
    if(any(cond, na.rm=TRUE)) {
      levels(x)[cond] <- value
    }
  } else {
    cond <- fun(x, template)
    if(any(cond, na.rm=TRUE)) {
      x <- replace(x, cond, value)
    }
  }
  x
}


