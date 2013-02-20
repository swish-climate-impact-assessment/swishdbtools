
################################################################
# name:postgis_join_attributes

postgis_join_attributes <- function(channel,
    tablename, zones, into, zonesid.x, zonesid.y = zones.x, simplify = 0.02, eval = FALSE){
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


#                cat(
         sql <-  paste("
                 select t1.*,
                 st_simplify(the_geom, ",simplify,") as the_geom
                 into ",into,"
                 from ",tablename," t1
                 join ",zones," t2
                 on ",zonesid.x," =
                  ",zonesid.y,";

                 alter table ",into," add column gid serial primary key;",
                 sep = "")

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
