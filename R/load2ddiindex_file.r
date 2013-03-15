
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
      if(length(grep("PRODDATEDOCFILE", names(filedscr))) > 0)
        {
          filedscr$PRODDATEDOCFILE <- format(as.Date(
                                      substr(filedscr$PRODDATEDOCFILE,1,10),'%Y-%m-%d'
                                      ),"%d/%b/%Y")
        }
    dbSendUpdate(ch,
    # cat(
      paste('
      insert into FILEDSCR (',paste(names(filedscr), sep = '', collapse = ', '),')
      VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(filedscr),'',filedscr)),sep='',collapse="', '"),"'",sep=''),')',sep='')
    )

      }
  }
