
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
# format dates for oracle
  stdydscr$PRODDATESTDY <- format(as.Date( substr(stdydscr$PRODDATESTDY,1,10),'%Y-%m-%d'),"%d/%b/%Y")
  stdydscr$PRODDATEDOC <- format(as.Date( substr(stdydscr$PRODDATEDOC,1,10),'%Y-%m-%d'),"%d/%b/%Y")

  dbSendUpdate(conn,
  #   cat(
    paste('
    insert into STDYDSCR (',paste(names(stdydscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(stdydscr),'',stdydscr)),sep='',collapse="', '"),"'",sep=''),')',sep='')
    )
  }
}
