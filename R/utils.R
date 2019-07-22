# helper function for performing replacements with `in` operators
in_replace <- function(x, fun, template, value) {
  if(is.factor(x)) {
    cond <- fun(levels(x), template)
    if(any(cond)) {
      levels(x)[cond] <- value
    }
  } else {
    cond <- fun(x, template)
    if(any(cond)){
      x <- replace(x, cond, value)
    }
  }
  x
}


