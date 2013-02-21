
################################################################
# name:postgis_join_attributes

postgis_join_attributes <- function(channel,
    tablename, zones, into, zonesid.x, zonesid.y = zones.x, simplify = 0.02, eval = FALSE, postgis_version = 1.5){
    ## channel = ch
    ## zones = 'abs_poa.nswpoa01'
    ## tablename = 'qcmap_rain'
    ## variable = 'totalssum'
    ## into = paste(tablename,1,sep = "")
    ## zonesid = 'poa_code'
    ## simplify = 0.02
    ## tidy = FALSE
    # test <- try(dbGetQuery(ch,paste("select ",zonesid," from ",into," limit 1;", sep = "")))
    # if(length(test) > 0){
    #   dbSendQuery(ch,paste("drop table ", into))
    # }
   if(length(grep("\\.",into)) == 0)
    {
      schema <- "public"
      table <- into
    } else {
      schema <- strsplit(into, "\\.")[[1]][1]
      table <- strsplit(into, "\\.")[[1]][2]
    }
  

#                cat(
         sql <-  paste("
                 select t1.*,
                 st_simplify(the_geom, ",simplify,") as the_geom
                 into ",schema,".",table,"
                 from ",tablename," t1
                 join ",zones," t2
                 on ",zonesid.x," =
                  ",zonesid.y,";

                 alter table ",schema,".",table," add column gid serial primary key;",
                 sep = "")

    if(postgis_version != 2)
      {
         fixgeom <- paste("INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, \"type\")
 SELECT '', '",schema,"', '",table,"', 'the_geom', ST_CoordDim(the_geom), ST_SRID(the_geom), GeometryType(the_geom)
 FROM ",schema,".",table," LIMIT 1;", sep = "")
        sql <- paste(sql,fixgeom,sep = "\n")
      }

    if(eval)
    {
    dbSendQuery(ch, sql)
    dbSendQuery(ch, paste("grant select on",into,"to public_group"))
    } else {
    return(sql)
    }
  #  shp <- readOGR2(hostip = NA, user = NA, db = NA, layer = NA, p = p)
    ## if(tidy == TRUE){
    ##   dbSendQuery(ch,'drop table temp;')
    ##   dbSendQuery(ch,'drop table temp1;')
    ## }

  }
