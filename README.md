
<!-- README.md is generated from README.Rmd. Please edit that file -->

# inops

The package *inops* provides operators which expand to sets, ranges and
regular expressions the functionality provided by the `%in%` infix
operator, while keeping their behavior close to the one of equality,
inequality and comparison operators (see dedicated section).

Operators can be categorized as follow :

  - **detection operators** return a logical output (as `%in%` does)
  - **subsetting operators** return a subset of the input.
  - **assignment operators** overwrite the values of the input matches
    by the set, range, or regular expression.

Install with:

    remotes::install_github("moodymudskipper/inops")

## Detection operators

Detection operators are the most important as subsetting and assignment
operators are simple wrappers around them, they are of the form `%<in or
out><suffix>%`.

### Set operations with `%in{}%`

`%in{}%` is very similar with `%in%` at first sight.

``` r
library(rangeops)
#> 
#> Attaching package: 'rangeops'
#> The following object is masked from 'package:base':
#> 
#>     <<-
8:11 %in{}% 1:10
#> [1]  TRUE  TRUE  TRUE FALSE
```

The difference is that it behaves consistently with `==`, which means
that it can be used on object of different types or classes and the
output will be of the same shape.

For instance we can use `%in{}%` on data frames :

``` r
df1 <- data.frame(a = 1:3, b = 2:4, c=letters[1:3])
df1 == 2
#>          a     b     c
#> [1,] FALSE  TRUE FALSE
#> [2,]  TRUE FALSE FALSE
#> [3,] FALSE FALSE FALSE
df1 %in% 2
#> [1] FALSE FALSE FALSE
df1 %in{}% 2
#>          a     b     c
#> [1,] FALSE  TRUE FALSE
#> [2,]  TRUE FALSE FALSE
#> [3,] FALSE FALSE FALSE
df1 %in{}% 2:3
#>          a     b     c
#> [1,] FALSE  TRUE FALSE
#> [2,]  TRUE  TRUE FALSE
#> [3,]  TRUE FALSE FALSE
```

Missing values are not turned to `FALSE` :

``` r
NA == 1
#> [1] NA
NA %in% 1
#> [1] FALSE
NA %in{}% 1
#> [1] NA
c(1,NA, 3) %in{}% 1:10
#> [1] TRUE   NA TRUE
```

All “in” operators of this package come with a “out” counterpart.

``` r
c(1,NA, 3) %out{}% 1:10
#> [1] FALSE    NA FALSE
```

We won’t mention the other “out” operators in the rest of the document,
nor the behavior of operators on non atomic data datypes, for brievety,
but they work just the same for other *inops* operator, with the
exception of `%out%`, the negation of `%in%` provided for convenience.

### Range operations with `%in[]%`, `%in[)%`, `%in(]%` and `%in()`

These check if values are in a given range, the rhs can be a simple pair
of values or a bigger set, in which case the range of these values will
be considered.

`[` and `]` describe closed boundaries while `(` and `)` describe open
boundaries.

``` r
8:12 %in[]% c(9, 10, 6)
#> [1]  TRUE  TRUE  TRUE FALSE FALSE
8:12 %in[)% c(9, 10, 6)
#> [1]  TRUE  TRUE FALSE FALSE FALSE
```

### Regex operations with `%in~%`, `%in~p%` and `%in~f%`

These operators are wrappers around `grepl()`, `%in~%` uses the default
parameters while `%in~p%` uses `perl = TRUE` and `%in~f%` uses `fixed =
TRUE`.

``` r
c("foo","bar","baz") %in~% c("^f","z$")
#> [1]  TRUE FALSE  TRUE
```

## Subsetting operators

All detection operators have a subsetting operator counterpart, they are
of the form `%[<in or out><suffix>%`.

`%in%` and `%out%` were given subsetting counterparts `%[in%` and
`%[out%` as well.

``` r
8:12 %[in[)% c(9, 10, 6)
#> [1] 8 9
8:12 %[out% c(5, 7, 9, 11)
#> [1]  8 10 12
c("foo","bar","baz") %[in~% c("^f","z$")
#> [1] "foo" "baz"
```

## Assignment operators

All detection operators have an assignment operator counterpart, it is
in practice typed just the same, but is followed by an assignment.

`%in%` and `%out%` were also given assignment counterparts `%in%<-` and
`%out%<-`, as were also `==`, `!=`, `<`, `>`, `<=` and `=>`.

``` r
x <- 1:10
x %in[]% c(4:6) <- 0
x
#>  [1]  1  2  3  0  0  0  7  8  9 10

x <- c("foo","bar","baz")
x %in~% c("^f","z$") <- "!!!"
x
#> [1] "!!!" "bar" "!!!"

x <- 1:10
x < 3 <- 0
x
#>  [1]  0  0  3  4  5  6  7  8  9 10
```

Note that to give an assignment counterpart to `<` we had to overload
the `<<-` operator, which explains the message when attaching the
package. This doesn’t affect the behavior of the `<<-` assignments.
