require(testthat)
if(!require(RPostgreSQL)) install.packages('RPostgreSQL', repos='http://cran.csiro.au'); require(RPostgreSQL)
con <- dbConnect(PostgreSQL(),host='115.146.84.135', user= 'gislibrary', password='gislibrary', dbname='ewedb')

#dbGetQuery(con,'select * from dbsize')

test_that('postgis connects', {
  expect_that(nrow(dbGetQuery(con,'select * from dbsize')) > 0, is_true())
})