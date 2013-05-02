
################################################################
# name:swish_temptable
swish_temptable <- function(database = "ewedb", prefix = "foo")
  {
    passwordTable <- get_passwordTable()
    recordIndex <- which(passwordTable$V3 == database)
    if(length(recordIndex) == 1)
    {
      pgpass <- passwordTable[recordIndex,]
    } else {
      stop("there are more than one usernames for that database in your passwords file.  can't proceed") 
    }
    
    temptableName <- tempfile(prefix, tmpdir = "", fileext = "")
    temp_table_name <- gsub("/", "", gsub("\\\\", "", temptableName))
    
    tempTableName <- list()
    tempTableName[["table"]] <- temp_table_name    
    tempTableName[["schema"]] <- pgpass$V4
    tempTableName[["fullname"]] <- paste(pgpass$V4, temp_table_name, sep = ".")
    return(tempTableName)        
  }
