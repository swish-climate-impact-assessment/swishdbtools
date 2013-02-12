
################################################################
# name:points2geom
points2geom <- function(schema,tablename,col_lat,col_long, srid="4283"){
  table <- sprintf("%s.%s",schema,tablename)

  sql1 <- sprintf(
    "SELECT AddGeometryColumn('%s', '%s', 'the_geom', %s, 'POINT', 2);\n",
    schema,tablename, srid)

  sql2 <- sprintf(
    "ALTER TABLE %s ADD CONSTRAINT geometry_valid_check CHECK (st_isvalid(the_geom));\n" ,
    table)

  sql3 <- sprintf("
              UPDATE %s
              SET the_geom=st_GeomFromText(
              'POINT('||
              %s ||
              ' '||
              %s ||')'
              ,%s);\n",table,col_long,col_lat, srid)

 sql4 <- paste("alter table ",schema,".",tablename," add column gid serial primary key;
               ALTER TABLE ",schema,".",tablename," ALTER COLUMN the_geom SET NOT NULL;
               CREATE INDEX ",tablename,"_gist on ",schema,".",tablename," using GIST(the_geom);
               ALTER TABLE ",schema,".",tablename," CLUSTER ON ",tablename,"_gist;
               ", sep = "")
               

  sql <- paste(sql1, sql2, sql3, sql4, sep = "\n")
}
