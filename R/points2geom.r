
################################################################
# name:points2geom
points2geom <- function(schema,tablename,col_lat,col_long){
  table <- sprintf("%s.%s",schema,tablename)

  sql1 <- sprintf(
    "SELECT AddGeometryColumn('%s', '%s', 'the_geom', 4283, 'POINT', 2);\n",
    schema,tablename)

  sql2 <- sprintf(
    "ALTER TABLE %s ADD CONSTRAINT geometry_valid_check CHECK (isvalid(the_geom));\n" ,
    table)

  sql3 <- sprintf("
              UPDATE %s
              SET the_geom=GeomFromText(
              'POINT('||
              %s ||
              ' '||
              %s ||')'
              ,4283);\n",table,col_long,col_lat)

  sql <- paste(sql1, sql2, sql3, sep = "\n")
}
