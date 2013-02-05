
################################################################
# name:ddiindexdb_remove_file
require(swishdbtools)
source("R/ddiindexdb_remove_file.r")
p <- getPassword()
ddiindexdb <- connect2oracle('115.146.93.225', 'ddiindexdb', p = p)
ddiindexdb_remove_file(ddiindexdb, x = "public.baseball")
