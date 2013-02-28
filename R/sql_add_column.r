
################################################################
# name:sql_add_column
#Adding a new column with data from a join
#http://stackoverflow.com/questions/8097384/adding-a-new-column-with-data-from-a-join
# alter table A add column3 [yourdatatype];

# update A set column3 = (select column3 from B where A.Column1 = B.Column2)
#   where exists (select column3 from B where A.Column1 = B.Column2)

  sql_add_column <- function(conn, x, from_table, col_name, col_type = "numeric", eval = F, variable1, ...)
  {

    argumentNames <- c(deparse(substitute(variable1)), sapply(substitute(list(...))[-1], deparse))
    argumentNames <- paste(collapse = ", ", argumentNames)

    categoryExpression <- paste(sep = "", x, ".", variable1 ," = ",from_table,".", variable1)
    otherVariables <- list(...)
    for(variableIndex in 1:length(otherVariables))
    {
      variable <- otherVariables[[variableIndex]]
      categoryExpression <- paste(sep="", categoryExpression, "\r\n", " and ", x, ".", variable, " = ",from_table,".", variable)
    }

#     categoryExpression2 <- paste(sep = "", x,".", variable1 ," = foo.", variable1)
# #    otherVariables <- list(...)
#     for(variableIndex in 1:length(otherVariables))
#     {
#       variable <- otherVariables[[variableIndex]]
#       categoryExpression2 <- paste(sep="", categoryExpression2,
#                                    "\r\n", " and ", x, ".", variable, " = foo.", variable)
#     }

    # variables <- c(variable1, otherVariables)
    # variables <- paste("t1.",variables, sep = "", collapse = ",")


    sql <- paste("alter table ",x," add ",col_name," ",col_type,";
    update ",x,"
    set  ",col_name," = (
    select  ",col_name,"
    from ", from_table, "
    where ",
    categoryExpression, "
    )
    ", sep = "")

    if(!eval)
    {
      return(sql)
    } else {

      dbSendQuery(ch, sql)
    }

  }
