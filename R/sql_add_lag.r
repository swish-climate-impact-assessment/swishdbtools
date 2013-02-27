
################################################################
# name:sql_add_column
  sql_add_lag <- function(conn, x, col_name, shift = 1, col_type =
                          "numeric", eval = F, variable1, ...)
  {

    argumentNames <- c(deparse(substitute(variable1)), sapply(substitute(list(...))[-1], deparse))
    argumentNames <- paste(collapse = ", ", argumentNames)

    categoryExpression <- paste(sep = "", "t1.", variable1 ," = t2.", variable1)
    otherVariables <- list(...)
    for(variableIndex in 1:length(otherVariables))
    {
      variable <- otherVariables[[variableIndex]]
      categoryExpression <- paste(sep="", categoryExpression, "\r\n", " and ", "t1.", variable, " = t2.", variable)
    }

    categoryExpression2 <- paste(sep = "", x,".", variable1 ," = foo.", variable1)
#    otherVariables <- list(...)
    for(variableIndex in 1:length(otherVariables))
    {
      variable <- otherVariables[[variableIndex]]
      categoryExpression2 <- paste(sep="", categoryExpression2,
                                   "\r\n", " and ", x, ".", variable, " = foo.", variable)
    }

    variables <- c(variable1, otherVariables)
    variables <- paste("t1.",variables, sep = "", collapse = ",")


    sql <- paste("alter table ",x," add ",col_name,"_lag",shift," ",col_type,";
    update ",x,"
    set  ",col_name,"_lag",shift," = (
    select  ",col_name,"_lag",shift,"
    from
    (
    select ",variables,", t1.date, t2.",col_name," as ",col_name,"_lag",shift,"
                 from ",x," t1
                 left join
                 ",x," t2
                 on ",
    categoryExpression
                 ,"
    and t1.date = t2.date + ",shift,"
    ) foo
    where ",
    categoryExpression2, "
    and ",x,".date = foo.date
    )
                 ", sep = "")

    if(!eval)
    {
      return(sql)
    } else {

      dbSendQuery(ch, sql)
    }

  }
