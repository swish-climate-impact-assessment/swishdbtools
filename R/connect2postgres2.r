
################################################################
# name:connect2postgres2
connect2postgres2 <- function(database, host=NA, user = NA)
{
if(!require(fgui)) install.packages("fgui", repos='http://cran.csiro.au'); require(fgui)
if(is.na(host) | is.na(user))
  {
   pgpass <- guiv(get_pgpass,
                  argOption=list(savePassword=c("TRUE","FALSE")))
   ch <- connect2postgres(hostip = pgpass[1], db=database,
                          user=pgpass[4], p = pgpass[5])
  } else {
   pgpass <- get_pgpass(host = host, user = user)
   ch <- connect2postgres(hostip = host, db=database,
                          user=user, p = pgpass[5])
  }

   return(ch)
}
