
################################################################
# name:load2ddiindex_file
  source("R/connect2oracle.r")
  source("R/add_filedscr.r")
  source("R/getPassword.r")
  source("R/load2ddiindex_file.r")
  
  pwd <- getPassword(remote=T)
  ch <- connect2oracle('115.146.93.225', db="DDIINDEXDB", p = pwd)
  if(!exists('file'))
  {
    file <- add_filedscr(ask = T)
  }

  load2ddiindex_file(conn = ch, file)
