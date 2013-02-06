
test_that('password returns string with characters', {
  expect_that(nchar(getPassword(remote = T))>0, is_true())
#  expect_that(nchar(getPassword(remote = F))>0, is_true())
  # getPassword(remote = T))
  # expect_that(is.character(getPassword(remote = T)), is_true)
})


# dev tests
# getPassword(remote = T)
# getPassword(remote = F)
