
################################################################
# name:load2ddiindex_file
  
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