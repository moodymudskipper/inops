expect_same_behavior <- function(object, expected, ...){
  object_chr <- deparse(substitute(object))
  expected_chr <- deparse(substitute(expected))
  quiet <- purrr::safely(purrr::quietly(identity))
  object   <- eval(substitute(quiet(object)))
  expected <- eval(substitute(quiet(expected)))
  testthat::expect(
    identical(object$result$result, expected$result$result, ...),
    sprintf("`%s` and `%s` don't return the same result.", object_chr, expected_chr))
  testthat::expect(
    identical(object$result$output, expected$result$output, ...),
    sprintf("`%s` and `%s` don't print the same output", object_chr, expected_chr))
  testthat::expect(
    identical(object$result$messages, expected$result$messages, ...),
    sprintf("`%s` and `%s` don't print the same messages", object_chr, expected_chr))
  testthat::expect(
    identical(object$result$warnings, expected$result$warnings, ...),
    sprintf("`%s` and `%s` don't trigger the same warnings", object_chr, expected_chr))
  testthat::expect(
    identical(object$error$message, expected$error$message, ...),
    sprintf("`%s` and `%s` don't trigger the same error", object_chr, expected_chr))
  invisible(NULL)
}

context("consistency of check ops with equality/comparison ops")

test_chr <- c(names(iris), NA)
test_num <- c(1:5,NA)
test_list1 <- c(as.list(c(1:5,NA)),
                as.list(c(letters[1:5], NA)),
                as.list(factor(c(letters[1:5], NA))))
test_list2 <- list(1:3, c(4:5,NA) ,
                   letters[1:3], c(letters[4:5], NA),
                   factor(c(letters[1:5], NA)))
test_df <- data.frame(
  a = 1:3, b = c(4:5,NA), c = letters[1:3], d = c(letters[4:5], NA),
  e = factor(letters[1:3]), f = factor(c(letters[4:5], NA)),stringsAsFactors = FALSE)

test_that("`%in{}%` is consistent with `==`",{
  expect_same_behavior(test_chr == "Petal.Length", test_chr %in{}% "Petal.Length")
  expect_same_behavior(test_num == 3, test_num %in{}% 3)
  expect_same_behavior(test_list1 == 3, test_list1 %in{}% 3)
  expect_same_behavior(test_list2 == 3, test_list2 %in{}% 3)
  expect_same_behavior(test_df == 3, test_df %in{}% 3)

  expect_same_behavior(
    test_chr == "Petal.Length" | test_chr == "Sepal.Length",
    test_chr %in{}% c("Petal.Length", "Sepal.Length"))
  expect_same_behavior(
    test_num == 3 | test_num == 4,
    test_num %in{}% c(3,4))
  expect_same_behavior(
    test_list1 == 3 | suppressWarnings(test_list1 == 4), # suppressWarnings to have just 5 warnings
    test_list1 %in{}% c(3,4))
  expect_same_behavior(test_list2 == 3 | test_list2 == 4, test_list2 %in{}% 3)
  expect_same_behavior(test_df == 3 | test_df == 4, test_df %in{}% c(3,4))
})

test_that("`%in[]%` is consistent with `>=` and `<=`",{
  expect_same_behavior(
    test_num >= 2.5 & test_num <= 4.5,
    test_num %in[]% c(2.5,4.5))
  expect_same_behavior(
    test_list1 >= 2.5 & test_list1 <= 4.5,
    test_list1 %in[]% c(2.5,4.5))
  expect_same_behavior(test_list2 >= 2.5 & test_list2 <= 4.5, test_list2 %in[]% c(2.5,4.5))
  expect_same_behavior(test_df >= 2.5 & test_df <= 4.5, test_df %in[]% c(2.5,4.5))
})

test_that("`%in[)%` is consistent with `>=` and `<`",{
  expect_same_behavior(
    test_num >= 2.5 & test_num < 4.5,
    test_num %in[)% c(2.5,4.5))
  expect_same_behavior(
    test_list1 >= 2.5 & test_list1 < 4.5,
    test_list1 %in[)% c(2.5,4.5))
  expect_same_behavior(test_list2 >= 2.5 & test_list2 < 4.5, test_list2 %in[)% c(2.5,4.5))
  expect_same_behavior(test_df >= 2.5 & test_df < 4.5, test_df %in[)% c(2.5,4.5))
})

test_that("`%in(]%` is consistent with `>` and `<=`",{
  expect_same_behavior(
    test_num > 2.5 & test_num <= 4.5,
    test_num %in(]% c(2.5,4.5))
  expect_same_behavior(
    test_list1 > 2.5 & test_list1 <= 4.5,
    test_list1 %in(]% c(2.5,4.5))
  expect_same_behavior(test_list2 > 2.5 & test_list2 <= 4.5, test_list2 %in(]% c(2.5,4.5))
  expect_same_behavior(test_df > 2.5 & test_df <= 4.5, test_df %in(]% c(2.5,4.5))
})

test_that("`%in()%` is consistent with `>` and `<`",{
  expect_same_behavior(
    test_num > 2.5 & test_num < 4.5,
    test_num %in()% c(2.5,4.5))
  expect_same_behavior(
    test_list1 > 2.5 & test_list1 < 4.5,
    test_list1 %in()% c(2.5,4.5))
  expect_same_behavior(test_list2 > 2.5 & test_list2 < 4.5, test_list2 %in()% c(2.5,4.5))
  expect_same_behavior(test_df > 2.5 & test_df < 4.5, test_df %in()% c(2.5,4.5))
})
