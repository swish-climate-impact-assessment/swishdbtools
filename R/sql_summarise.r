
################################################################
# name:sql_summarise
  sql_summarise <- function(conn, x, .dimensions, .variables, .fun, eval = FALSE, check = T)
  {
    # assume ch exists
    if(length(grep("\\.",x)) == 0)
      {
        schema <- "public"
        table <- x
      } else {
        schema <- strsplit(x, "\\.")[[1]][1]
        table <- strsplit(x, "\\.")[[1]][2]
      }
    if(check)
      {
      exists <- pgListTables(conn, schema, table)
      if(nrow(exists) == 0)
      {
        stop("Table doesn't exist.")
      }

      }
    dimensionsList <- paste(.dimensions, collapse = ", ", sep = "")
  if(.variables == "*")
    {
      variablesList <- names(
                       dbGetQuery(conn,
                        paste("select * from ",
                        schema, ".",
                        table, " limit 1",
                        sep = ""))
                       )
      variablesList <- variablesList[-which(variablesList == .dimensions)]
    } else {
      variablesList <- .variables
    }
    fun <- paste("), ",.fun, "(", sep = "")
    # TODO
    variablesList
    .fun
    variableslist <- paste(paste(.fun, "(", variablesList, ")", sep =
    ""),"as", paste(variablesList, "_", .fun, sep = ""), collapse =", ")

    #paste(paste(func, "(", vars, ")", sep = ""),"as", paste(vars, "_",
    #  func, sep = ""), collapse =", ")
    # variableslist <-  paste(.fun, "(",
    #                         paste(variablesList, collapse = fun, sep =
    #                    ""),
    #                         ")", sep ="")

#variableslist
    sqlquery <- paste("select ", dimensionsList, ", ", variableslist, "\nfrom ", schema, ".",
                      table, "\ngroup by ",dimensionsList,"\norder by ",dimensionsList,
                      sep = "")
# cat(sqlquery)

    if(eval)
      {
        dat <- dbGetQuery(conn,sqlquery)
        return(dat)
      } else {
        return(sqlquery)
      }

  }
