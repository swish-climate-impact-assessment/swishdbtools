
################################################################
# name:sql_summarise

require(swishdbtools)
source("R/sql_summarise.r")
require(plyr)
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
head(baseball)
head(
plycount <- ddply(baseball, "id", summarise,
 duration = max(year) - min(year))
#                  ,
# nteams = length(unique(team)))
#)
ewedb <- connect2postgres2('ewedb')
sql_subset(ewedb, 'baseball', limit = 10, eval = T)
undebug(sql_summarise)
sqlmax <- sql_summarise(
  conn = ewedb
  ,
  x = "baseball"
  ,
  .dimensions = "id"
  ,
  .variables = "year"
  ,
  .fun = "max"
  ,
  eval = T
  ,
  check = T
  )
sqlmin <- sql_summarise(ewedb, 'baseball', 'id', 'year', 'min', eval =
                        T)
sqlcount <- merge(sqlmax, sqlmin)
sqlcount$duration <- sqlcount$max - sqlcount$min
head(sqlcount)

head(plycount)
