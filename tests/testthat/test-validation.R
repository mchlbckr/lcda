test_that("manifest variables must be consecutive integers", {
  data <- data.frame(x = c(0, 1, 2), y = c(1, 1, 2))
  grouping <- c(1, 1, 2)

  expect_error(
    cclcda2(x = data, grouping = grouping, m = 1),
    "Manifest variables must be coded"
  )
})

test_that("grouping must be consecutive integers", {
  data <- data.frame(x = c(1, 2, 1), y = c(1, 1, 2))
  grouping <- c(0, 1, 2)

  expect_error(
    cclcda2(x = data, grouping = grouping, m = 1),
    "Grouping must be coded"
  )
})
