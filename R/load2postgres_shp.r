
################################################################

  load2postgres_shp <- function(filename, out_schema, out_table,  ipaddress = "115.146.84.135", u = "gislibrary", d = 'ewedb', pgisutils = "", srid = 4283, remove = TRUE, eval = FALSE)
  {
    outname <- paste(out_schema, out_table, sep = ".")
    os <- LinuxOperatingSystem()
    if(os)
    {
#      system(
    #        cat
           sql <- paste(pgisutils,"shp2pgsql -s ",srid," -D ",filename," ",outname," > ",outname,".sql", sep="")
            #)

     #system(
    #        cat
            cli <- paste("psql -h ",ipaddress," -U ",u," -d ",d," -f ",outname,".sql",
              sep = "")
            #)
    if(eval)
      {
        system(sql)
        system(cli)
        file.remove(paste(outname, '.sql', sep =""))
      } else {
        sql <- paste(sql, cli, sep = "\n")
        return(sql)
      }


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

      }
  }
