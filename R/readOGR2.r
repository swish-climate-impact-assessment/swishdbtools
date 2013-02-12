
################################################################
# name:readOGR2
readOGR2 <- function(hostip=NA,user=NA,db=NA, layer=NA, p = NA) {
 # NOTES
 # only works on Linux OS
 # returns uninformative error due to either bad connection or lack of record in geometry column table.  can check if connection problem using a test connect?
 # TODO add a prompt for each connection arg if isna
 if (!require(rgdal)) install.packages('rgdal', repos='http://cran.csiro.au'); require(rgdal)
 if(is.na(p)){ 
 pwd=readline('enter password (ctrl-L will clear the console after): ')
 } else {
 pwd <- p
 }
 shp <- readOGR(sprintf('PG:host=%s
                         user=%s
                         dbname=%s
                         password=%s
                         port=5432',hostip,user,db,pwd),
                         layer=layer)

 # clean up
 rm(pwd)
 return(shp)
 }
