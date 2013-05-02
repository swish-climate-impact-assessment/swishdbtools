
################################################################
# name:swish_temptable
require(swishdbtools)
ch <- connect2postgres2("ewedb")
df <- as.data.frame(rep("hello_ewedb", 10))
names(df) <- "hello_ewedb"
tempTableName <- swish_temptable("ewedb")
dbWriteTable(ch, tempTableName$table, df, row.names = F)
tested <- sql_subset(ch, tempTableName$fullname, eval = T)
dbSendQuery(ch, 
  sprintf("drop table %s", tempTableName$fullname)
  )
tested
