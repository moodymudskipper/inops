
<!-- README.md is generated from README.Rmd. Please edit that file -->

# inops

Package implementing additional infix operators for R.

Implemented operators provide 3 distinct operations: **detection**,
**subsetting**, and **replacement**.  
And work with 4 different value types: **sets**, **intervals**,
**regular expressions**, and **counts**.

Install using the `remotes` package:

    remotes::install_github("moodymudskipper/inops")

## Examples

Simple examples for illustration.

-----

Selecting flight records from the `flights` dataset that:

1.  Departed and Landed between noon and 5 p.m.
2.  Were not traveling to “LEX”, “PSP”, nor “HDN”
3.  Travelled distance was either very short (below 100) or very long
    (above 3000)
4.  Had a tail number starting with “N1” or “N3”

<!-- end list -->

``` r
library(nycflights13)
library(dplyr)
library(inops)

flights %>%
  filter(dep_time %in()%  c(1200, 1700)) %>%
  filter(arr_time %in()%  c(1200, 1700)) %>%
  filter(dest     %out%   c("LEX", "PSP", "HDN")) %>%
  filter(distance %out[]% c(100, 3000)) %>%
  filter(tailnum  %in~%   c("^N1", "^N3")) %>%
  select(origin, dest, tailnum, dep_time, arr_time, distance)
#> # A tibble: 2 x 6
#>   origin dest  tailnum dep_time arr_time distance
#>   <chr>  <chr> <chr>      <int>    <int>    <dbl>
#> 1 EWR    PHL   N14972      1240     1333       80
#> 2 JFK    HNL   N391HA      1214     1645     4983
```

-----

Cleaning up `planes` dataset in order to:

1.  Standardize names of “AIRBUS”, “CANADAIR” and “MCDONNELL”
    manufacturers.
2.  Obtain plane counts for each of the 3 manufacturers mentioned above.

<!-- end list -->

``` r
library(nycflights13)
library(inops)

table(planes$manufacturer %[in~% c("AIRBUS", "CANADAIR", "MCDONNELL"))
#> 
#>                        AIRBUS              AIRBUS INDUSTRIE                      CANADAIR 
#>                           336                           400                             9 
#>                  CANADAIR LTD             MCDONNELL DOUGLAS MCDONNELL DOUGLAS AIRCRAFT CO 
#>                             1                           120                           103 
#> MCDONNELL DOUGLAS CORPORATION 
#>                            14

planes$manufacturer %in~% "AIRBUS"    <- "AIRBUS"
planes$manufacturer %in~% "CANADAIR"  <- "CANADAIR"
planes$manufacturer %in~% "MCDONNELL" <- "MCDONNELL"

table(planes$manufacturer %[in~% c("AIRBUS", "CANADAIR", "MCDONNELL"))
#> 
#>    AIRBUS  CANADAIR MCDONNELL 
#>       736        10       237
```

-----

Combine engine models that in the dataset occur less than 6 times under
the “Other” group.

``` r
library(nycflights13)
library(inops)

table(planes$engine)
#> 
#>       4 Cycle Reciprocating     Turbo-fan     Turbo-jet    Turbo-prop   Turbo-shaft 
#>             2            28          2750           535             2             5

planes$engine %in#% 1:5 <- "Other"

table(planes$engine)
#> 
#>         Other Reciprocating     Turbo-fan     Turbo-jet 
#>             9            28          2750           535
```

-----

## Operators

Introduction to operator behaviour and design.

### Form

All operators have the same form composed of two distinct parts:
`%<operation><type>%`.

  - `[operation]` specifies the performed operation and can be one of
    `in`, `out`, `[in`, `[out`.
  - `[type]` specifies the type of operation and can be one of `{}`,
    `[]`, `()`, `[)`, `(]`, `~`, `~p`, `~f`, `#`.

To understand what each combination does see the table below.

### Behaviour

The operators implemented here try to be consistent with the default
comparison operators like `==` and `<`.  
Therefore in some scenarios their behaviour differs from `%in%`.  
For instance:

1)  `%in{}%` can be used on on data frames.

<!-- end list -->

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

2)  missing values are not considered as not matching.

<!-- end list -->

``` r
NA == 1
#> [1] NA

NA %in% 1
#> [1] FALSE

NA %in{}% 1
#> [1] NA

NA %in% NA
#> [1] TRUE

NA %in{}% NA
#> [1] NA

c(1, NA, 3) %in{}% 1:10
#> [1] TRUE   NA TRUE
```

### Operations

Operators permit three distinct operations:

1.  Detect: `x %in{}% set`
2.  Subset: `x %[in{}% set`
3.  Replace: `x %in{}% set <- value`

## Operator List

Below is a full list of all the implemented operators along with their
usage examples.

### Detection Operators

| Form      | Description                                                 | Call                 |
| --------- | ----------------------------------------------------------- | -------------------- |
| `%in{}%`  | which elements are inside a set                             | `x %in{}% set`       |
| `%in[]%`  | which elements are inside a closed interval                 | `x %in[]% interval`  |
| `%in()%`  | which elements are inside an open interval                  | `x %in()% interval`  |
| `%in[)%`  | which elements are inside an interval open on the right     | `x %in[)% interval`  |
| `%in(]%`  | which elements are inside an interval open on the left      | `x %in(]% interval`  |
| `%in~%`   | which elements match a regular expression                   | `x %in~% pattern`    |
| `%in~p%`  | which elements match a regular perl expression              | `x %in~p% pattern`   |
| `%in~f%`  | which elements match a regular fixed expression             | `x %in~f% pattern`   |
| `%in#%`   | which elements occur a specified number of times            | `x %in#% count`      |
| `%out%`   | which elements are outside a set (same as \! x %in% y)      | `x %out% set`        |
| `%out{}%` | which elements are outside a set                            | `x %out{}% set`      |
| `%out[]%` | which elements are outside a closed interval                | `x %out[]% interval` |
| `%out()%` | which elements are outside an open interval                 | `x %out()% interval` |
| `%out[)%` | which elements are outside an interval open on the right    | `x %out[)% interval` |
| `%out(]%` | which elements are outside an interval open on the left     | `x %out(]% interval` |
| `%out~%`  | which elements do not match a regular expression            | `x %out~% pattern`   |
| `%out~p%` | which elements do not match a regular perl expression       | `x %out~p% pattern`  |
| `%out~f%` | which elements do not match a regular fixed expression      | `x %out~f% pattern`  |
| `%out#%`  | which elements occur other than a specified number of times | `x %out#% count`     |

### Subsetting Operators

| Form       | Description                                                     | Call                  |
| ---------- | --------------------------------------------------------------- | --------------------- |
| `%[in%`    | select elements inside a set                                    | `x %[in% set`         |
| `%[in{}%`  | select elements inside a set                                    | `x %[in{}% set`       |
| `%[in[]%`  | select elements inside a closed interval                        | `x %[in[]% interval`  |
| `%[in()%`  | select elements inside an open interval                         | `x %[in()% interval`  |
| `%[in[)%`  | select elements inside an interval open on the right            | `x %[in[)% interval`  |
| `%[in(]%`  | select elements inside an interval open on the left             | `x %[in(]% interval`  |
| `%[in~%`   | select elements matching a regular expression                   | `x %[in~% pattern`    |
| `%[in~p%`  | select elements matching a regular perl expression              | `x %[in~p% pattern`   |
| `%[in~f%`  | select elements matching a regular fixed expression             | `x %[in~f% pattern`   |
| `%[in#%`   | select elements that occur a specified number of times          | `x %[in#% count`      |
| `%[out%`   | select elements outside a set                                   | `x %[out%  set`       |
| `%[out{}%` | select elements outside a set                                   | `x %[out{}%  set`     |
| `%[out[]%` | select elements outside a closed interval                       | `x %[out[]% interval` |
| `%[out()%` | select elements outside an open interval                        | `x %[out()% interval` |
| `%[out[)%` | select elements outside an interval open on the right           | `x %[out[)% interval` |
| `%[out(]%` | select elements outside an interval open on the left            | `x %[out(]% interval` |
| `%[out~%`  | select elements not matching a regular expression               | `x %[out~% pattern`   |
| `%[out~p%` | select elements not matching a regular perl expression          | `x %[out~p% pattern`  |
| `%[out~f%` | select elements not matching a regular fixed expression         | `x %[out~f% pattern`  |
| `%[out#%`  | select elements that occur other than specified number of times | `x %[out% count`      |

### Replacement Operators

| Form        | Description                                                     | Call                          |
| ----------- | --------------------------------------------------------------- | ----------------------------- |
| `==<-`      | change elements equal to the provided value                     | `x == element <- value`       |
| `!=<-`      | change elements not equal to the provided value                 | `x != element <- value`       |
| `><-`       | change elements greater than the provided value                 | `x > number <- value`         |
| `<<-`       | change elements lower than the provided value                   | `x < number  <- value`        |
| `>=<-`      | change elements greater or equal to the provided value          | `x >= number <- value`        |
| `<=<-`      | change elements lower or equal to the provided value            | `x <= number <- value`        |
| `%in%<-`    | change elements inside a set                                    | `x %in% set <- value`         |
| `%in{}%<-`  | change elements inside a set                                    | `x %in{}% set <- value`       |
| `%in[]%<-`  | change elements inside a closed interval                        | `x %in[]% interval <- value`  |
| `%in()%<-`  | change elements inside an open interval                         | `x %in()% interval <- value`  |
| `%in[)%<-`  | change elements inside an interval open on the right            | `x %in[)% interval <- value`  |
| `%in(]%<-`  | change elements inside an interval open on the left             | `x %in(]% interval <- value`  |
| `%in~%<-`   | change elements matching a regular expression                   | `x %in~% pattern <- value`    |
| `%in~p%<-`  | change elements matching a regular perl expression              | `x %in~p% pattern <- value`   |
| `%in~f%<-`  | change elements matching a regular fixed expression             | `x %in~f% pattern <- value`   |
| `%in#%<-`   | change elements that occur specified number of times            | `x %in#% count <- value`      |
| `%out%<-`   | change elements outside a set                                   | `x %out% set <- value`        |
| `%out{}%<-` | change elements outside a set                                   | `x %out{}% set <- value`      |
| `%out[]%<-` | change elements outside a closed interval                       | `x %out[]% interval <- value` |
| `%out()%<-` | change elements outside an open interval                        | `x %out()% interval <- value` |
| `%out[)%<-` | change elements outside an interval open on the right           | `x %out[)% interval <- value` |
| `%out(]%<-` | change elements outside an interval open on the left            | `x %out(]% interval <- value` |
| `%out~%<-`  | change elements not matching a regular expression               | `x %out~% pattern <- value`   |
| `%out~p%<-` | change elements not matching a regular perl expression          | `x %out~p% pattern <- value`  |
| `%out~f%<-` | change elements not matching a regular fixed expression         | `x %out~f% pattern <- value`  |
| `%out#%<-`  | change elements that occur other than specified number of times | `x %out#% count <- value`     |

## Notes

To give an assignment counterpart to `<` we had to overload the `<<-`
operator, which explains the message when attaching the package. This
doesn’t affect the behavior of the `<<-` assignments.
