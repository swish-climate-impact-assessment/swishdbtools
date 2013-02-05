
################################################################
# name:test-make_ddixml
source("R/make_ddixml.r")
require(swishdbtools)
    if(!exists('p'))
    {
      pwd <- getPassword(remote=T)
    }

    ch <- connect2oracle('115.146.93.225', db="DDIINDEXDB", p = pwd)

stdydscr <- dbGetQuery(ch,
                   "select * from stdydscr where idno = 'R_DATASETS'")
file <- dbGetQuery(ch,
                   "select * from filedscr where idno = 'R_DATASETS'")
file
for(fid in file$FILEID)
  {
#    fid = file$FILEID[1]
    datadscr <- dbGetQuery(ch,
                          paste("select * from datadscr where fileid = '",fid,"'",
                          sep = "")
                          )

#datadscr
    file_i <- file[file$FILEID==fid,]
  make_ddixml(s = stdydscr, f=file_i, d=datadscr, writeXML= T)
  }
