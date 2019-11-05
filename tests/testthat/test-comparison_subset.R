test_that("comparison/equality subsetting ops are working", {
  expect_equal(1:3 %[==% 2, 2)
  expect_equal(1:3 %[!=% 2, c(1,3))
  expect_equal(1:3 %[<=% 2, c(1,2))
  expect_equal(1:3 %[>=% 2, c(2,3))
  expect_equal(1:3 %[<% 2, 1)
  expect_equal(1:3 %[>% 2, 3)
})
