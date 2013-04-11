
################################################################
# name:read_file
require(devtools)
install_github("swishdbtools", "swish-climate-impact-assessment")
filename <- file.path(Sys.getenv("TEMP"), "airquality.dta")
write.dta(airquality, filename)
write.csv(airquality, gsub("dta", "csv", filename), row.names=FALSE)
# manually convert to xls
dir("/tmp")
df <- read_file(filename)
df <- read_file(gsub("dta","xls",filename))
df <- read_file(gsub("dta","csv",filename))
