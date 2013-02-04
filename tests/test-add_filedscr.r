
################################################################
# name:test-add_stdydscr

source("R/add_filedscr.r")
 
file <- add_filedscr(fileid = 1, idno = 'TESTSTUDY', ask=T)

t(file)
