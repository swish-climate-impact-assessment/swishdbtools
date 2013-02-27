
################################################################
# name:sqldf_lag
  sqldf_lag <- function(df, x, shift = 1, eval = F, variable1, ...)
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
    sql <- paste("
    select t1.*, t2.",x," as ",x,"_lag",shift,"
                 from ",df," t1
                 left join
                 ",df," t2
                 on ",
    categoryExpression
                 ,"
    and t1.date = t2.date + ",shift,"
                 ", sep = "")
  
    if(!eval)
    {
      return(sql)
    } else {
      data_lagged <- sqldf(sql, drv = "SQLite")
      return(data_lagged)
    }
  
  }
