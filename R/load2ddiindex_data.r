
################################################################
# name:load2ddiindex_data

load2ddiindex_data <- function(conn, filepath, datadscr)
 {
   if(length(grep("\\.",filepath)) == 0)
    {
      schema <- "public"
      table <- filepath
    } else {
      schema <- strsplit(filepath, "\\.")[[1]][1]
      table <- strsplit(filepath, "\\.")[[1]][2]
    }

sql <- sql_subset(ch, 'ddiindexdb.filedscr',
                  subset = paste("filelocation = '",schema,"' and filename = '",table,"'", sep =""),
                  eval=F, check =F)
#cat(sql)
file <- dbGetQuery(ch, sql)
fid <- file$FILEID
#fid
datadscr$FILEID <- fid
for(i in 1:nrow(datadscr))
  {
  dbSendUpdate(ch,
    paste('
    insert into DATADSCR (',paste(names(datadscr), sep = '', collapse = ', '),')
    VALUES (',paste("'",paste(gsub("'","",ifelse(is.na(datadscr[i,]),'',datadscr[i,])),sep='',collapse="', '"),"'",sep=''),')',sep='')
   )

  }
}
