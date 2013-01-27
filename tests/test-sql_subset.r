
#require(swishdbtools)
ch <- connect2postgres('localhost', db='django', user='gislibrary', p='gislibrary')
test_that('postgis data exists', {
  expect_that(is.character(sqlquery_select(conn=ch, select='srid, srtext',x='spatial_ref_sys', limit = 2, subset = "srid = 4283", eval = F)), is_true())
  expect_that(nrow(sqlquery_select(conn=ch, select='srid, srtext',x='spatial_ref_sys', limit = 2, subset = "srid = 4283", eval = T))==1, is_true())
})

#
# # dev tests
# ch <- connect2postgres('115.146.84.135', db='ewedb', user='gislibrary', p='gislibrary')
 sql <- sql_subset(conn=ch, x='spatial_ref_sys',
                   subset = "srid = 4283", select='srid, srtext',
                   limit = 2, eval = T)
## cat(sql) # if eval=F
 nrow(sql)==1 # if eval=T
#### from subset man page ####
head(subset(airquality, Temp > 80, select = c(Ozone, Temp)))
str(airquality)
# tempdata <- airquality
# names(tempdata) <- tolower(names(tempdata))
# names(tempdata) <- gsub('\\.', '_',names(tempdata))
# str(tempdata)
# dbWriteTable(ch, 'airquality', tempdata)
# rm(tempdata)
sql_subset(ch, 'airquality', 'Temp > 80', 'Ozone, Temp', eval = T)
