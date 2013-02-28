
################################################################
# name:sql_transform
   sql_transform <- function(conn, x,
                             eval = FALSE, check = T,
                             col_type = "float8",
                             variable1, ...)
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
      tablename <- paste(schema_x,".",table_x, sep = "")
      argumentNames <- c(deparse(substitute(variable1)), sapply(substitute(list(...))[-1], deparse))
      argumentNames <- paste(collapse = ", ", argumentNames)

      categoryExpression <- paste(sep = "", "t1.", variable1 ," = t2.", variable1)
      otherVariables <- list(...)
      for(variableIndex in 1:length(otherVariables))
      {
        variable <- otherVariables[[variableIndex]]
        categoryExpression <- paste(sep="", categoryExpression, "\r\n", " and ", "t1.", variable, " = t2.", variable)
      }


     if(check)
       {
       exists <- pgListTables(conn, schema_x, table_x)
       if(nrow(exists) == 0)
       {
         stop("Table x doesn't exist.")
       }

       }

      col_name <- gsub(" ", "", unlist(strsplit(variable1, "=")[[1]][1]))
#      col_transformation <- gsub(" ", "", unlist(strsplit(variable1, "=")[[1]][2]))
      namesExist <- sql_subset(conn, tablename, limit = 1, eval = T)
      if(length(which(col_name ==  names(namesExist)) > 0) == 0)
        {
        sql <- paste("alter table ", tablename," add ",col_name," ",col_type,";
        update ", tablename ,"
        set  ",variable1,"
        ", sep = "")
        } else {
        sql <- paste("
        update ", tablename ,"
        set  ",variable1,"
        ", sep = "")
        }


     #cat(sql)

     if(eval)
       {
         dbSendQuery(conn,sql)

       } else {
         return(sql)
       }


   }
