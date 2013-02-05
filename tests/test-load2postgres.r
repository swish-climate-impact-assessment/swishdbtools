
################################################################
# name:test-load2postgres
source("R/load2postgres.r")
#### from subset man page ####
head(subset(airquality, Temp > 80, select = c(Ozone, Temp)))
str(airquality)
tempdata <- airquality
names(tempdata) <- tolower(names(tempdata))
names(tempdata) <- gsub('\\.', '_',names(tempdata))
str(tempdata)
# dbWriteTable(ch, 'airquality', tempdata)
write.csv(tempdata, 'airquality.csv', row.names=F, na = "")
# rm(tempdata)
require(swishdbtools)
if(!exists('p'))
{
  p <- getPassword()
}
ewedb <- connect2postgres('115.146.84.135', db='ewedb',
                       user='gislibrary', p=p)
dbSendQuery(ewedb, 'drop table airquality')
load2postgres('airquality.csv','public', 'airquality', pguser =
              'gislibrary', ip = '115.146.84.135', db='ewedb', print = F)

# from plyr
require(plyr)
head(baseball)
write.csv(baseball, 'baseball.csv', row.names=F, na = "")
load2postgres('baseball.csv','public', 'baseball', pguser =
              'gislibrary', ip = '115.146.84.135', db='ewedb', print = F)
