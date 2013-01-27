################################################################
# name:sqlquery_insert

sqlquery_insert <- function(channel, variables="*",
                            from_schema = 'public', from_table,
                            where=NA, limit=1, eval = FALSE)
{
  # assume ch exists
  exists <- pgListTables(channel, from_schema, from_table)
  if(nrow(exists) == 0)
    {
      stop("Table doesn't exist.")
    }

  if(variables=="*")
    {
      variables <- names(
                     dbGetQuery(channel,
                      paste("select ", variables, " from ",
                      from_schema, ".",
                      from_table, " limit 1",
                      sep = ""))
                     )
      variables <- paste(variables, collapse = ", ", sep = "")
    }

  sqlquery <- paste("select ", variables, "\nfrom ", from_schema, ".",
                    from_table, "\n",
                    sep = "")

  if(!is.na(where))
    {
      sqlquery <- paste(sqlquery, "where ", where, "\n", sep = "")
    }

  if(limit > 0)
    {
      sqlquery <- paste(sqlquery, "limit ", limit, "\n", sep = "")
    }

  if(eval)
    {
      dat <- dbGetQuery(channel,sqlquery)
      return(dat)
    } else {
      return(sqlquery)
    }

}
