
################################################################
# name:swish_temptable
swish_temptable <- function(prefix = "foo")
  {
    temptableName <- tempfile(prefix, tmpdir = "", fileext = "")
    temp_table_name <- gsub("/", "", gsub("\\\\", "", temptableName))
    return(temp_table_name )        
  }
