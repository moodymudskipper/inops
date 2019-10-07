test_that("comparison/equality assignment ops with work", {
  x <- 1:3
  x == 2 <- 4
  expect_equal(x, c(1,4,3))
  x <- 1:3
  x != 2 <- 4
  expect_equal(x, c(4,2,4))
  x <- 1:3
  x <= 2 <- 4
  expect_equal(x, c(4,4,3))
  x <- 1:3
  x >= 2 <- 4
  expect_equal(x, c(1,4,4))
  x <- 1:3
  x < 2 <- 4
  expect_equal(x, c(4,2,3))
  x <- 1:3
  x > 2 <- 4
  expect_equal(x, c(1,2,4))
})

test_that("<<- works in its original form", {
  y <<- 4
  expect_equal(y, 4)
})
