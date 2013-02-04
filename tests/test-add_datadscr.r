
################################################################
# name:test-add_datadscr
  source("R/add_datadscr.r")
  require(swishdbtools)
  if(!exists('p'))
  {
    p <- getPassword()
  }
  ewedb <- connect2postgres('localhost', db='django',
                         user='gislibrary', p=p)
  pwd <- getPassword(remote=T)
  ch <- connect2oracle('115.146.93.225', db="DDIINDEXDB", p = pwd)

  airquality <- sql_subset(ewedb, 'airquality', limit = 1, eval = T)
  airquality
  file <- dbGetQuery(ch, "select * from filedscr where idno = 'R_DATASETS'")
  fid <- dbGetQuery(ch,
  #                  cat(
                    paste("select FILEID
                    from filedscr
                    where filelocation = '",file$FILELOCATION,"'
                    and filename = '",file$FILENAME,"'",
                    sep=''))
  datadscr <- add_datadscr(data_frame = airquality, fileid = fid[1,1], ask=T)


  for(i in 1:nrow(datadscr)){
  dbSendUpdate(ch,
  #i = 1
  # cat(
  paste('
  insert into DATADSCR (',paste(names(datadscr), sep = '', collapse = ', '),')
  VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(datadscr[i,]),'',datadscr[i,])),sep='',collapse="', '"),"'",sep=''),')',sep='')
  )
  }
