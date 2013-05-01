
################################################################
# name:swish_tempfile
swish_tempfile <- function(df = NA, eval = F, prefix = "foo", fext = ".dta")
  {
    tempdir <-  Sys.getenv("TEMP")
    if(nchar(tempdir)==0) stop("Your tempdir is empty, please set it with Sys.setenv(TEMP = '/tmp') for eg.")
    tempFileName <- tempfile(prefix, tmpdir = tempdir, fileext = fext)
    if(eval == T)
      {
        write.dta(df, tempFileName)
        return(tempFileName )
      } else {
        return(tempFileName )        
      }
  }
