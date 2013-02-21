
################################################################
# name:readGDAL2
require(swishdbtools)
pwd <- getPassword()
rast <- readGDAL2(hostip="115.146.84.135",user="gislibrary",
            db="ewedb",schema = "awap_grids",table= "maxave_20130108",p = pwd)

image(rast)
