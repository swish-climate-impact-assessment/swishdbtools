
################################################################
# name:sql_join
  sql_join <- function(conn, x, y, select.x = "*", select.y = "*", by, by.x = by, by.y = by,
                              type = "left", eval = FALSE, check = T)
  {
    # assume ch exists
    if(length(grep("\\.",x)) == 0)
      {
        schema_x <- "public"
        table_x <- x
      } else {
        schema_x <- strsplit(x, "\\.")[[1]][1]
        table_x <- strsplit(x, "\\.")[[1]][2]
      }
    if(length(grep("\\.",y)) == 0)
      {
        schema_y <- "public"
        table_y <- y
      } else {
        schema_y <- strsplit(y, "\\.")[[1]][1]
        table_y <- strsplit(y, "\\.")[[1]][2]
      }



    if(check)
      {
      exists <- pgListTables(conn, schema_x, table_x)
      if(nrow(exists) == 0)
      {
        stop("Table x doesn't exist.")
      }

      }


    ## if(check & select=="*")
    ##   {
    ##     select <- names(
    ##                    dbGetQuery(conn,
    ##                     paste("select ", select, " from ",
    ##                     schema, ".",
    ##                     table, " limit 1",
    ##                     sep = ""))
    ##                    )
    ##     select <- paste(select, collapse = ", ", sep = "")
    ##   }

    sqlquery <- paste("select t1.", select.x, ", t2.", select.y ,
                      "\nfrom ",
                      schema_x , ".",
                      table_x , " t1\n",
                      type, " join\n",
                      schema_y , ".",
                      table_y , " t2\n",
                      "on t1.", by.x, " = t2.", by.y,
                      sep = "")
cat(sqlquery)
    ## if(!is.na(subset))
    ##   {
    ##     sqlquery <- paste(sqlquery, "where ", subset, "\n", sep = "")
    ##   }

    ## if(limit > 0)
    ##   {
    ##     sqlquery <- paste(sqlquery, "limit ", limit, "\n", sep = "")
    ##   }

    if(eval)
      {
        dat <- dbGetQuery(conn,sqlquery)
        return(dat)
      } else {
        return(sqlquery)
      }


  }
