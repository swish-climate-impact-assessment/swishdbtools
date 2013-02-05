
################################################################
# name:load2ddiindex_data
source('R/load2ddiindex_data.r')
require(swishdbtools)
filepath <- "public.baseball"
p <- getPassword()
ch <- connect2oracle('115.146.93.225', db='DDIINDEXDB', p=p)
load2ddiindex_data(ch, filepath = "public.baseball", datadscr)
