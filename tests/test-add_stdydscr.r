
################################################################
# name:test-add_stdydscr
source("R/connect2oracle.r")
source("R/add_stdydscr.r")
source("R/getPassword.r")

pwd <- getPassword(remote=T)
ch <- connect2oracle('115.146.93.225', db="DDIINDEXDB", p = pwd)

stdy <- add_stdydscr(idno='TESTSTUDY', 'A TEST OF THE DDI FUNCTION',
                     ask = T)
t(stdy)
