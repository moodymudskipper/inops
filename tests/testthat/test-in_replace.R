test_that("assignment range ops work", {
  x <- 1:3
  x %in% c(2, 4) <- 4
  expect_equal(x, c(1, 4, 3))
  x <- 1:3
  x %in{}% c(2, 4) <- 4
  expect_equal(x, c(1, 4, 3))
  x <- 1:3
  x %in()% c(2, 4) <- 4
  expect_equal(x, c(1, 2, 4))
  x <- 1:3
  x %in(]% c(2, 4) <- 4
  expect_equal(x, c(1, 2, 4))
  x <- 1:3
  x %in[)% c(2, 4) <- 4
  expect_equal(x, c(1, 4, 4))
  x <- 1:3
  x %in[]% c(2, 4) <- 4
  expect_equal(x, c(1,4,4))
  x <- 1:3
  x %out% c(2, 4) <- 4
  expect_equal(x, c(4, 2, 4))
  x <- 1:3
  x %out{}% c(2, 4) <- 4
  expect_equal(x, c(4, 2, 4))
  x <- 1:3
  x %out()% c(2, 4) <- 4
  expect_equal(x, c(4, 4, 3))
  x <- 1:3
  x %out(]% c(2, 4) <- 4
  expect_equal(x, c(4, 4, 3))
  x <- 1:3
  x %out[)% c(2, 4) <- 4
  expect_equal(x, c(4, 2, 3))
  x <- 1:3
  x %out[]% c(2, 4) <- 4
  expect_equal(x, c(4, 2, 3))
})


test_that("assignment regex ops work",{
  x <- letters[1:2]
  x %in~% "^a" <- "c"
  expect_equal(x, c("c", "b"))
  x <- letters[1:2]
  x %in~p% "^a" <- "c"
  expect_equal(x, c("c", "b"))
  x <- letters[1:2]
  x %in~f% "a" <- "c"
  expect_equal(x, c("c", "b"))
  x <- letters[1:2]
  x %out~% "^a" <- "c"
  expect_equal(x, c("a", "c"))
  x <- letters[1:2]
  x %out~p% "^a" <- "c"
  expect_equal(x, c("a", "c"))
  x <- letters[1:2]
  x %out~f% "a" <- "c"
  expect_equal(x, c("a", "c"))

})
