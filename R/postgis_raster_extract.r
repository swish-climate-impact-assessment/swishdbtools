
################################################################
postgis_raster_extract <- function(conn, x, y, fun = NA, into = FALSE,
                                   eval = FALSE)
{
  
    dbSendQuery(conn,
                #  cat(
                paste("SELECT pt.",varID,", cast('",date_i,"' as date) as date,
                      ST_Value(rt.rast, pt.the_geom) as ",measure_i,"
                      into awap_grids.",measure_i,"_join_", pwcName,
                      " FROM awap_grids.",measure_i,"_",date_name," rt,
                      ",pwcName," pt
                      WHERE ST_Intersects(rast, the_geom)
                      ", sep ="")
                )

    
}
