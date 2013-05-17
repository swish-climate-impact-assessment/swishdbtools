
################################################################
# name:test-make_ddixml
source("R/make_ddixml.r")
require(swishdbtools)
    if(!exists('p'))
    {
      pwd <- getPassword(remote=T)
    }

    ch <- connect2oracle('115.146.93.108', db="DDIINDEXDB", p = pwd)
    
stdy  <- "AWAP_GRIDS"
stdydscr <- dbGetQuery(ch,
                   sprintf("select * from stdydscr where idno = '%s'", stdy)
                       )
file <- dbGetQuery(ch,
                   sprintf("select * from filedscr where idno = '%s' and publishddi = 1", stdy)
                   )
file[,1:3]
for(fid in file$FILEID)
  {
    #fid = file$FILEID[1]
    datadscr <- dbGetQuery(ch,
                          paste("select * from datadscr where fileid = '",fid,"'",
                          sep = "")
                          )

#datadscr
    file_i <- file[file$FILEID==fid,]
  make_ddixml(s = stdydscr, f=file_i, d=datadscr, writeXML= T)
  }
