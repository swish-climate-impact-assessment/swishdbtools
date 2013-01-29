
source("R/sql_subset.r")
source("R/sql_subset_into.r")
source("R/pgListTables.r")

ch <- connect2postgres('115.146.84.135', db='ewedb', user='gislibrary', p='gislibrary')
sql_subset_into(ch, 'dbsize',into_table='temp101', select = '*', eval=T)
dbSendQuery(ch, 'drop table temp101')
