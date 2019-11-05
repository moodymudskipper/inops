test_that("subset ops work", {
  expect_equal(1:3 %[in% c(2,4), 2)
  expect_equal(1:3 %[in{}% c(2,4), 2)
  expect_equal(1:3 %[in()% c(2,4), 3)
  expect_equal(1:3 %[in[)% c(2,4), 2:3)
  expect_equal(1:3 %[in(]% c(2,4), 3)
  expect_equal(1:3 %[in[]% c(2,4), 2:3)
  expect_equal(c(1,1,3) %[in#% 2, c(1,1))
  expect_equal(1:3 %[out% c(2,4), c(1,3))
  expect_equal(1:3 %[out{}% c(2,4), c(1,3))
  expect_equal(1:3 %[out()% c(2,4), 1:2)
  expect_equal(1:3 %[out[)% c(2,4), 1)
  expect_equal(1:3 %[out(]% c(2,4), 1:2)
  expect_equal(1:3 %[out[]% c(2,4), 1)
  expect_equal(c(1,1,3) %[out#% 2, 3)
})

test_that("subset regex ops work", {
  expect_equal(letters[1:2] %[in~% "^a", "a")
  expect_equal(letters[1:2] %[in~p% "^a", "a")
  expect_equal(letters[1:2] %[in~f% "a", "a")

  expect_equal(letters[1:2] %[out~% "^a", "b")
  expect_equal(letters[1:2] %[out~p% "^a", "b")
  expect_equal(letters[1:2] %[out~f% "a", "b")
})


