
################################################################
# name:load2ddiindex
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


load2ddiindex_file <- function(conn=NA, filedscr)
{



  if(exists('filedscr'))
    {
    fileexists <- dbGetQuery(conn,
                paste("select * from filedscr where filename = '",filedscr$FILENAME,"' and filelocation ='",filedscr$FILELOCATION,"'", sep="")
                )
    if(nrow(fileexists) > 0) stop('File record already exists.')
    
  dbSendUpdate(ch,
  # cat(
    paste('
    insert into FILEDSCR (',paste(names(filedscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(filedscr),'',filedscr)),sep='',collapse="', '"),"'",sep=''),')',sep='')
  )

    }
}
