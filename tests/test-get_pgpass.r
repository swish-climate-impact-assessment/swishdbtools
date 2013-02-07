
################################################################
# name:get_pgpass
source("R/LinuxOperatingSystem.r")
source("R/get_pgpass.r")

#undebug(get_pgpass)
pgpass <- get_pgpass(database = "ewedb", host="115.146.84.135", user="ivan_hanigan", savePassword = TRUE)
pgpass
