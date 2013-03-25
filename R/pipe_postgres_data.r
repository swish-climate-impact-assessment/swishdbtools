
################################################################
# name:pipe_postgres_data
  pipe_postgres_data <- function(ip_source = "localhost",
                        user = "user", db_source = "database",
                        ip_target, db_target)
    {
  
      sql <- paste("psql -d ",db_target," -U ",user," -h ",ip_target,"
      CREATE SCHEMA ",schema,";
      grant ALL on schema ",schema," to public_group;
      \\q
  
      pg_dump -h ",ip_source," -U ",user," -i -n ",schema," ",db_source," | psql -h ",ip_target," -U ",user," ",db_target,"
  
      # now on the remote server run
      psql ",db_target," ",user," -h ",ip_target,"
      GRANT select ON ALL TABLES IN SCHEMA ",schema," TO public_group;
      ", sep ="")
  
    return(sql)
    }
