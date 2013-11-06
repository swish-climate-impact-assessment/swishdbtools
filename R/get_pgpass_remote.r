
################################################################
# name:get_pgpass_remote
get_pgpass_remote <- function(db=NA,hostip=NA,user=NA,p=NA)
{
  if(is.na(hostip)){
    hostip=readline('enter hostip: ')
  } 
  if(is.na(db)){
    db=readline('enter db: ')
  }
  if(is.na(user)){
    user=readline('enter user: ')
  }
  if(is.na(p)){
    p=readline(paste('enter password for user ',user, ': ',sep=''))
  } 
  pgstring <- paste(hostip,":5432:",db,":",user,":",p,"\n", sep = "")
  append_to_pgpass <- file.exists("~/.pgpass")
  sink('~/.pgpass', append = append_to_pgpass)
  cat(pgstring)
  sink()
}
