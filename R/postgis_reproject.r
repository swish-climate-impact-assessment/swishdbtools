
################################################################
# name:postgis_reproject
postgis_reproject <- function(conn, x, srid, out_table = NA, eval = F)
  {
    if(length(grep("\\.",x)) == 0)
      {
        schema <- "public"
        table <- x
      } else {
        schema <- strsplit(x, "\\.")[[1]][1]
        table <- strsplit(x, "\\.")[[1]][2]
      }
    if(is.na(out_table))
      {
        out_table <- paste(table,"_reprojected", sep = "")
      }

    namesList <- names(sql_subset(conn, paste(schema, table, sep = "."), eval = T))
    namesList <- c(namesList[-c(which(namesList == "gid"))], "geom")

    sql <- sql_subset_into(
                           conn,
                           paste(schema,".",table,sep=""),
                           select = paste(
                             gsub("geom", sprintf("st_transform(geom, %s) as geom", srid), namesList),
                             sep = "", collapse = ","
                             ),
                           into_schema = schema,
                           into_table = out_table,
                           eval = F
                           )

    sql <- paste(sql,";\n",
                 sprintf("alter table %s.%s add column gid serial primary key;",schema, out_table),
                 sep = ""
                 )

    if(eval == FALSE)
      {
        return(sql)
      } else {
        dbSendQuery(conn, sql)
      }

  }
