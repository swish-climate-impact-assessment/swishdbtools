
################################################################
# name:load2ddiindex_data

    file <- dbGetQuery(ch, "select * from filedscr where idno = 'R_DATASETS'")  
    fid <- dbGetQuery(ch,
    #                  cat(
                      paste("select FILEID
                      from filedscr
                      where filelocation = '",file$FILELOCATION,"'
                      and filename = '",file$FILENAME,"'",
                      sep=''))

  
    for(i in 1:nrow(datadscr)){
    dbSendUpdate(ch,
    #i = 1
    # cat(
    paste('
    insert into DATADSCR (',paste(names(datadscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(datadscr[i,]),'',datadscr[i,])),sep='',collapse="', '"),"'",sep=''),')',sep='')
    )
    }
