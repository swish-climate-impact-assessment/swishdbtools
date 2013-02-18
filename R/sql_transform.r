
################################################################
# name:sql_transform
   sql_transform <- function(conn, x,
                             eval = FALSE, check = T)
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

 ## check cols exist in both and then paste together
     if(check & select.x=="*")
       {
         select_x <- names(
                        dbGetQuery(conn,
                         paste("select ", select.x, " from ",
                         schema_x, ".",
                         table_x, " limit 1",
                         sep = ""))
                        )

       }
 #    select_x
     if(check & select.y=="*")
       {
         select_y <- names(
                        dbGetQuery(conn,
                         paste("select ", select.y, " from ",
                         schema_y, ".",
                         table_y, " limit 1",
                         sep = ""))
                        )

       }
 #    select_y

     select.x <- paste("t1.", select_x,collapse = ", ", sep = "")
     for(.by in by)
       {
         recordIndex <- which(.by == select_y)
         select_y <- select_y[-recordIndex]
       }
     select.y <- paste("t2.",select_y, collapse = ", ", sep = "")

 #    select
     sqlquery <- paste("select ", select.x, ", ", select.y ,
                       "\nfrom ",
                       schema_x , ".",
                       table_x , " t1\n",
                       type, " join\n",
                       schema_y , ".",
                       table_y , " t2\n",
                       "on t1.", by.x, " = t2.", by.y,
                       sep = "")
#  cat(sqlquery)
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
