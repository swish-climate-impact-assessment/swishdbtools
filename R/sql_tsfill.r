
################################################################
# name:sql_tsfill
# NB see http://www.ats.ucla.edu/stat/stata/faq/fill_down.htm
# fills a variable in a table for missing combinations of variable1 ... variableN
# returns filled table
# 'variableName' to be filled
# 'fillValue' for filled variable 
# 'variable1' values for category variable 1, where names(variable1) is the name of variable1
# variable2, ...,  variableN - values and names of category variable 2 ... N
sql_tsfill <- function(tableIn, variableName, fillValue, variable1, ...)
{
  argumentNames <- c(deparse(substitute(variable1)), sapply(substitute(list(...))[-1], deparse))
  argumentNames <- paste(collapse = ", ", argumentNames)
  
  categoryExpression <- paste(sep = "", "t1.", names(variable1) ," = t2.", names(variable1))
  otherVariables <- list(...)
  for(variableIndex in 1:length(otherVariables)) 
  {
    variable <- otherVariables[[variableIndex]]
    categoryExpression <- paste(sep="", categoryExpression, "\r\n", " and ", "t1.", names(variable), " = t2.", names(variable))
  }
  
  tableName <- deparse(substitute(tableIn))
  case <- paste(sep = "", "case when ", variableName, " is null then ", fillValue, " else ", variableName, " end")
  joinExpression <- paste(sep = "", "(select * from ", argumentNames,") ", "\r\n", "t1 left join ", tableName, " t2 on ", "\r\n", categoryExpression)
  sql <- paste(sep = "", "select t1.*, ", "\r\n", case, "\r\n", " as ", variableName, " from ", "\r\n", joinExpression)
  
  tableOut <-  sqldf(sql, drv = 'SQLite')
  
  return(tableOut)
}
