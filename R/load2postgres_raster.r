
################################################################
# name:load2postgres_raster
load2postgres_raster <- function(filename, ipaddress = "115.146.84.135", u = "gislibrary", d = 'ewedb', pgisutils = "", srid = 4283, remove = TRUE)
{
  outname <- gsub('.tif',"", filename)
  outname <- substr(outname, 1, nchar(outname) - 8)
  os <- LinuxOperatingSystem()
  if(os == 'linux')
  {
   system(
  #        cat
          paste(pgisutils,"raster2pgsql -s ",srid," -I -C -M ",filename," -F awap_grids.",outname," > ",outname,".sql", sep="")
          )

   system(
  #        cat
          paste("psql -h ",ipaddress," -U ",u," -d ",d," -f ",outname,".sql",
            sep = ""))
  } else {
    sink('raster2sql.bat')
    cat(paste(pgisutils,"raster2pgsql\" -s ",srid," -I -C -M ",filename," -F awap_grids.",outname," > ",outname,".sql\n",sep=""))

    cat(
    paste(pgutils,"psql\" -h ",ipaddress," -U ",u," -d ",d," -f ",outname,".sql",
    sep = "")
      )
    sink()
    system('raster2sql.bat')
    file.remove('raster2sql.bat')
  }

  if(remove)
    {
      file.remove(filename)
      file.remove(paste(outname, '.sql', sep =""))
    }
}