
################################################################
# name:fixGeom
fixGeom <- function(conn, x, eval = F)
{
    if(length(grep("\\.",x)) == 0)
      {
        schema <- "public"
        table <- x
      } else {
        schema <- strsplit(x, "\\.")[[1]][1]
        table <- strsplit(x, "\\.")[[1]][2]
      }
    sql <- paste("
       INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, \"type\")
       SELECT '', '",schema,"', '",table,"', 'the_geom', ST_CoordDim(the_geom), ST_SRID(the_geom), GeometryType(the_geom)
       FROM ",schema,".",table," LIMIT 1;
      ",sep="")

    if(eval)
      {
        dbSendQuery(ch, sql)
      } else {
      return(sql)
      }
}
