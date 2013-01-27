
################################################################
# name:sqlquery_select

sql_subset <- function(conn, x, subset = NA, select = "*",
                            schema = 'public',
                            limit = -1, eval = FALSE)
{
  # assume ch exists
  exists <- pgListTables(conn, schema, x)
  if(nrow(exists) == 0)
    {
      stop("Table doesn't exist.")
    }

  if(select=="*")
    {
      select <- names(
                     dbGetQuery(conn,
                      paste("select ", select, " from ",
                      schema, ".",
                      x, " limit 1",
                      sep = ""))
                     )
      select <- paste(select, collapse = ", ", sep = "")
    }

  sqlquery <- paste("select ", select, "\nfrom ", schema, ".",
                    x, "\n",
                    sep = "")

  if(!is.na(subset))
    {
      sqlquery <- paste(sqlquery, "where ", subset, "\n", sep = "")
    }

  if(limit > 0)
    {
      sqlquery <- paste(sqlquery, "limit ", limit, "\n", sep = "")
    }

  if(eval)
    {
      dat <- dbGetQuery(conn,sqlquery)
      return(dat)
    } else {
      return(sqlquery)
    }

}
