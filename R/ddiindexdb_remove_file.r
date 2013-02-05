
################################################################
  # name:ddiindexdb_remove_file

  ddiindexdb_remove_file <- function(conn, x)
  {
  if(length(grep("\\.",x)) == 0)
    {
      schema <- "public"
      table <- x
    } else {
      schema <- strsplit(x, "\\.")[[1]][1]
      table <- strsplit(x, "\\.")[[1]][2]
    }

  fid <- dbGetQuery(ch,
              paste("delete from ddiindexdb.filedscr where filelocation = '",schema,"'  and filename = '",table,"'", sep ="")
                   )
#  fid

  dbSendUpdate(ch,
              paste("delete from ddiindexdb.datadscr where fileid = ",
              fid[1,1], sep ="")
              )

  dbSendUpdate(ch,
              paste("delete from ddiindexdb.filedscr where filelocation = '",schema,"'  and filename = '",table,"'", sep ="")
              )
  }
