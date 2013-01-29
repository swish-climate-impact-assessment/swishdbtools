
sql_subset_into <- function(conn, x, ..., into_schema = "public", into_table, eval = FALSE, drop = TRUE)
{
  sql <- sql_subset(ch, x=x, ..., eval=F)
  sql <- gsub('from', paste("into ", into_schema, ".", into_table, "\nfrom ", sep = ""), sql)
  if(eval)
  {
    exists <- pgListTables(conn, into_schema, into_table)
    if(nrow(exists) > 0 & drop)
      {
        dbSendQuery(conn, paste("drop table ", into_schema, ".",
                                into_table, sep =""))
      } else if (nrow(exists) > 0 & !drop)
        {
          stop("Table exists. Aborting.")
        }
  
    dbSendQuery(conn, sql)
    #dat <- dbGetQuery(conn, paste("select * from ", into_schema, ".", into_table, sep = ""))
    #return(dat)
  } else {
    return(sql)
  }
}
