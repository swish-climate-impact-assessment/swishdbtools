# ivanhanigan 2013-07-09
# purpose = simplify the postgis spatial data to allow faster transfer to clients or quicker visualisations
# arguments:
# channel = ch,
# schema = into this schema,
# table = create this spatial table, 
# tablename = from this,
# zone_code = a single uniqe column identifying the zones,
# simplify = larger values give more simplification
# eval = if FALSE just return the sql

require(swishdbtools)

postgis_simplify <- function(
  channel = ch,
  schema = NA ,
  table = NA, 
  tablename = NA,
  zone_code = NA,
  simplify = 0.2 ,
  eval = FALSE)
{
  sql <-  paste("
                select t1.",zone_code,",
                st_simplify(geom, ",simplify,") as geom
                into ",schema,".",table,"
                from ",tablename," t1;
                alter table ",schema,".",table," add column gid serial primary key;",
                sep = "")
  
  #cat(sql)
  
  if(eval == TRUE)
  {
    tbl_exists <- pgListTables(ch, schema, table)
    if(nrow(tbl_exists) > 0){
      dbSendQuery(ch, sprintf("drop table %s.%s", schema, table))
    }    
    dbSendQuery(ch, sql)  
  } else {
    return(sql)
  }
}

ch <- connect2postgres2("gislibrary")
# host = 'dc-geoserve.anu.edu.au',user='gislibrary',db='gislibrary'
pgListTables(ch, "abs_sd")
sql_subset(ch, "abs_sd.aussd07", eval = T, limit = 1)

sql <- postgis_simplify(
  channel = ch
  ,
  schema = 'public'
  ,
  table = 'aussd07_simplified'
  , 
  tablename = 'abs_sd.aussd07'
  ,
  zone_code = "sdname07"
  ,
  simplify = 0.5 
  ,
  eval = T
)

# cat(sql)  
#dbSendQuery(ch, "vacuum analyze")
#sql_subset(ch, "geometry_columns", eval = T)
pd <- getPassword()
pgListTables(ch, "public")

d <- readOGR2(hostip='dc-geoserve.anu.edu.au',user='gislibrary',db='gislibrary',layer=table, p = pd)
d2 <- readOGR2(hostip='dc-geoserve.anu.edu.au',user='gislibrary',db='gislibrary',layer=tablename, p = pd)
par(mfrow=c(1,2))
plot(d)
plot(d2)
dev.off()