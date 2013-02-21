
################################################################
# name:readGDAL2
readGDAL2 <- function(hostip=NA,user=NA,db=NA, schema=NA, table=NA, p = NA)
{
  sql <-
    paste("PG:host=",hostip," port=5432 dbname='",db,"' user='",user,"' password='",p,"' schema='",schema,"' table=", table,
            sep = "")

  r <- readGDAL(sql)
  return(r)
}
