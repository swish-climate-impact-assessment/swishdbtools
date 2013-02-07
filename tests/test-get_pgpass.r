
################################################################
# name:get_pgpass
source("R/LinuxOperatingSystem.r")
source("R/get_pgpass.r")
source("R/connect2postgres.r")
source("R/connect2postgres2.r")

#undebug(get_pgpass)
pgpass <- get_pgpass(host="115.146.84.135", user="ivan_hanigan", savePassword = TRUE)
pgpass

ch <- connect2postgres2()
pgpass
