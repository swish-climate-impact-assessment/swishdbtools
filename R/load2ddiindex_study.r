
################################################################
# name:load2ddiindex_study
load2ddiindex_study <- function(conn=NA, stdydscr)
{

  if(exists('stdydscr'))
    {
      stdyexists <- dbGetQuery(conn,
                paste("select * from stdydscr where idno = '",stdydscr$IDNO,"'", sep="")
                )
    if(nrow(stdyexists) > 0) stop('Study record already exists.')
    

  dbSendUpdate(conn,
  #   cat(
    paste('
    insert into STDYDSCR (',paste(names(stdydscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(stdydscr),'',stdydscr)),sep='',collapse="', '"),"'",sep=''),')',sep='')
    )
  }
}
