
################################################################
# name:get_passwordTable
    get_passwordTable <- function(fileName)
    {
      linux <- LinuxOperatingSystem()
      if(linux)
      {
        fileName <- "~/.pgpass"
      } else
      {
        directory <- Sys.getenv("APPDATA")
        fileName <- file.path(directory, "postgresql", "pgpass.conf")
      }
  
      exists <- file.exists(fileName)
      if (exists)
      {
        passwordTable <- read.table(fileName, sep = ":", stringsAsFactors=FALSE)
        return(passwordTable)
      }
  
    }
