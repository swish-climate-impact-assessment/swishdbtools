
################################################################

postgis_raster_extract <- function(conn, x, y, fun = NA, eval = FALSE, zone_label, value_label = NA, into = FALSE)
{
out_schema <- "public"
#                   into ",value_label,"_join_", pwcName,
sql <- paste("SELECT pt.",zone_label,", cast('",x,"' as text) as raster_layer,
ST_Value(rt.rast, pt.the_geom) as ",value_label,
"\nFROM ",x," rt,
",y," pt
WHERE ST_Intersects(rast, the_geom)
", sep ="")


if(into)
{
  out_table <- paste(y, "_extract_",value_label, sep = "")
  tblList <- pgListTables(conn, schema=out_schema)
  recordIndex <- which(tblList$relname == out_table)
  if(length(recordIndex) == 0)
  {
    sql <- gsub("\nFROM", paste("\nINTO ", out_schema, ".", out_table , "\nFROM ", sep = ""), sql)
  } else {
    sql_insert <- paste("INSERT INTO ", out_schema, ".", out_table, " (", zone_label, ", raster_layer, ", value_label, ")", sep = "")  
    sql <- paste(sql_insert, sql, sep = "\n")
  }

}

return(sql)  
#dbSendQuery(conn,
#    

}
