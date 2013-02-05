
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
# for files that are already loaded on ewedb
airquality <- sql_subset(ewedb, 'airquality', limit = 1, eval = T)
airquality
# else load the file from CSV or similar
baseball <- read.csv('baseball.csv')
# now add variable labels
datadscr <- add_datadscr(data_frame = airquality, fileid = 1, ask=T)
datadscr <- add_datadscr(data_frame = baseball, ask=T)
