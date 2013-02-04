
## install.packages("~/tools/swishdbtools_1.1_R_x86_64-pc-linux-gnu.tar.gz", repos = NULL, type = "source")
require(swishdbtools)
##  ch <- connect2postgres('localhost', db='django', user='gislibrary', p='gislibrary')
## test_that('postgis data exists', {
##   expect_that(is.character(sqlquery_select(conn=ch, select='srid, srtext',x='spatial_ref_sys', limit = 2, subset = "srid = 4283", eval = F)), is_true())
##   expect_that(nrow(sqlquery_select(conn=ch, select='srid, srtext',x='spatial_ref_sys', limit = 2, subset = "srid = 4283", eval = T))==1, is_true())
## })

#
# dev tests
source("R/sql_subset.r")
source("R/pgListTables.r")
if(!exists('p'))
{
  p <- getPassword()
}
 ch <- connect2postgres('115.146.84.135', db='ewedb', user='gislibrary', p=p)
 sql <- sql_subset(conn=ch, x='spatial_ref_sys',
                   subset = "srid = 4283", select='srid, srtext',
                   limit = 2, eval = T)
## cat(sql) # if eval=F
 nrow(sql)==1 # if eval=T
#### from subset man page ####
# head(subset(airquality, Temp > 80, select = c(Ozone, Temp)))
# str(airquality)
# tempdata <- airquality
# names(tempdata) <- tolower(names(tempdata))
# names(tempdata) <- gsub('\\.', '_',names(tempdata))
# str(tempdata)
# dbWriteTable(ch, 'airquality', tempdata)
# rm(tempdata)
source("R/sql_subset.r")
#sql_subset(ch, 'airquality', 'Temp > 80', 'Ozone, Temp', eval = T)
sql_subset(ch, 'dbsize', select = '*', into_table = 'temp101', eval=T)
dbSendQuery(ch, 'drop table temp101')
sql_subset(ch, 'dbsize', select = '*', eval=T)
