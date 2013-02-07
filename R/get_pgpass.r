
################################################################
  # name:get_pgpass
  get_pgpass <- function(host, user, savePassword = FALSE)
  {

    linux = LinuxOperatingSystem()
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

      hostColumn <- 1
      userColumn <- 4
      passwordColumn <- 5

      recordIndex <- which(passwordTable[,hostColumn] == host & passwordTable[,userColumn] == user)

      if (length(recordIndex > 0) > 0)
      {
        pgpass <- passwordTable[recordIndex, ]
        pgpass <- as.character(pgpass)
        return (pgpass)
      }
    }

    pgpass <- swishdbtools::getPassword()

    #TODO get user ok here, also on linux need to add
"WARNING: You have opted to save your password. It will be stored in plain text in your project files and in your home directory on Unix-like systems, or in your user profile on Windows. If you do not want this to happen, please press the Cancel button."

    #savePassword = TRUE

    if (savePassword)
    {
      record <- c(V1 = host, V2 = "5432", V3 = "*", V4 = user, V5 = pgpass)
      #record <- paste(host, ":5432:*:",  user,":",  pgpass, collapse = "", sep = "")
      record <- t(record)
      if (!exists("passwordTable"))
      {
        passwordTable <- as.data.frame(record)
      }else
      {
        passwordTable = rbind(passwordTable, record)
      }

      write.table(x = passwordTable, file = fileName, sep = ":", eol =
    "\r\n", row.names = FALSE, col.names = FALSE, quote = FALSE)
    }

    return (pgpass)
  }
