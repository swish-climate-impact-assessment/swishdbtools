
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
  fid <- dbGetQuery(ch,
  #                  cat(
                    paste("select FILEID
                    from filedscr
                    where filelocation = '",f$FILELOCATION,"'
                    and filename = '",f$FILENAME,"'",
                    sep=''))
  datadscr <- add_datadscr(data_frame = airquality, fileid = 1, ask=T)


  for(i in 1:nrow(d)){
  dbSendUpdate(ch,
  #i = 1
  # cat(
  paste('
  insert into DATADSCR (',paste(names(d), sep = '', collapse = ', '),')
  VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(d[i,]),'',d[i,])),sep='',collapse="', '"),"'",sep=''),')',sep='')
  )
  }
