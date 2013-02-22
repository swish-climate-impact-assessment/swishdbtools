
################################################################

load2postgres_shp <- function(filename, out_schema, out_table,  ipaddress = "115.146.84.135", u = "gislibrary", d = 'ewedb', pgisutils = "", srid = 4283, remove = TRUE)
{
  outname <- paste(out_schema, out_table, sep = ".")
  os <- LinuxOperatingSystem()
  if(os)
  {
   system(
  #        cat
          paste(pgisutils,"shp2pgsql -s ",srid," -D ",filename," ",outname," > ",outname,".sql", sep="")
          )

   system(
  #        cat
          paste("psql -h ",ipaddress," -U ",u," -d ",d," -f ",outname,".sql",
            sep = ""))
  } else {
    sink('shp2sql.bat')
    cat(paste(pgisutils,"shp2pgsql\" -s ",srid," -D ",filename," ",outname," > ",outname,".sql\n",sep=""))

    cat(
    paste(pgisutils,"psql\" -h ",ipaddress," -U ",u," -d ",d," -f ",outname,".sql",
    sep = "")
      )
    sink()
    system('shp2sql.bat')
    file.remove('shp2sql.bat')
  }

  if(remove)
    {
      file.remove(filename)
      file.remove(paste(outname, '.sql', sep =""))
    }
}
