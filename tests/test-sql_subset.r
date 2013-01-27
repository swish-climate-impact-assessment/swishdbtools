ch <- connect2postgres('115.146.84.135', db='ewedb', user='gislibrary', p='gislibrary')
test_that('postgis data exists', {
  expect_that(is.character(sqlquery_select(channel=ch, variables='srid, srtext',from_table='spatial_ref_sys', limit = 2, where = "srid = 4283", eval = F)), is_true())
  expect_that(nrow(sqlquery_select(channel=ch, variables='srid, srtext',from_table='spatial_ref_sys', limit = 2, where = "srid = 4283", eval = T))==1, is_true())
})

# 
# # dev tests
# ch <- connect2postgres('115.146.84.135', db='ewedb', user='gislibrary', p='gislibrary')
# sql <- sqlquery_select(channel=ch, variables='srid, srtext',from_table='spatial_ref_sys', limit = 2, where = "srid = 4283", eval = T)
# # cat(sql) # if eval=F
# nrow(sql)==1 # if eval=T
# # 
# head(subset(airquality, Temp > 80, select = c(Ozone, Temp)))
# subset(drop=)
# require(RPostgreSQL)
# dbGetQuery(conn=,statement=)