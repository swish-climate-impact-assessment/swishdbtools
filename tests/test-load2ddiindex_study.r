
################################################################
# name:test-load2ddiindex_study
source("R/connect2oracle.r")
source("R/add_stdydscr.r")
source("R/getPassword.r")
source("R/load2ddiindex_study.r")

pwd <- getPassword(remote=T)
ch <- connect2oracle('115.146.93.225', db="DDIINDEXDB", p = pwd)
if(!exists('stdy'))
{
  stdy <- add_stdydscr(ask = T)
}
t(stdy)

load2ddiindex_study(conn = ch, stdy)
