
################################################################
# name:load2ddiindex_data
require(swishdbtools)
#idno <- "R_DATASETS"
filename <- "baseball"
filelocation <- "public"
p <- getPassword()
ch <- connect2oracle('115.146.93.225', db='DDIINDEXDB', p=p)
sql <- sql_subset(ch, 'ddiindexdb.filedscr',
                   subset = paste("filelocation = '",filelocation,"'
                            and filename = '",filename,"'", sep =""),
                    eval=F, check =F)
cat(sql)
file <- dbGetQuery(ch, sql)
fid <- file$FILEID

    for(i in 1:nrow(datadscr)){
    dbSendUpdate(ch,
    #i = 1
    # cat(
    paste('
    insert into DATADSCR (',paste(names(datadscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(datadscr[i,]),'',datadscr[i,])),sep='',collapse="', '"),"'",sep=''),')',sep='')
    )
    }
