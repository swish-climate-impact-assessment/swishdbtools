
################################################################
# name:read_file
require(devtools)
install_github("swishdbtools", "swish-climate-impact-assessment")
filename <- file.path(Sys.getenv("TEMP"), "airquality.csv")
write.dta(airquality, filename)
dir("/tmp")
df <- read_file(filename)
