
################################################################
# name:load2postgres
# tools for loading data to postgres
# Joseph Guillame and Ivan Hanigan
# original by Joe 24/3/2009

# TO DO:
## set the vacuum automatically when printcopy=F
## on linux replace the 'type' command with 'cat'

# load_newtable_to_postgres = Convert to csv and load to postgres
# pk as either column names as they appear at the end or column indices

# inspired from
#odbc_dsn="pg"
#require(RODBC)
#con<-odbcConnect(odbc_dsn,"postgres","test",case="postgresql")
#sqlSave(con,data[0,],test=TRUE,verbose=TRUE)
#close(con)

# source file could be
#source_file=paste("E'", csvfilename,"'",sep="")


# if (!file.exists('C:/pgutils/psql.exe')) {
# dir.create('c:/pgutils')
# download.file("http://alliance.anu.edu.au/access/content/group/4e0f55f1-b540-456a-000a-24730b59fccb/pgutils.zip","c:/pgutils/pgutils.zip",mode="wb")
# unzip("c:/pgutils/pgutils.zip",exdir="C:/pgutils")
# }
# not working
# print('please download http://alliance.anu.edu.au/access/content/group/4e0f55f1-b540-456a-000a-24730b59fccb/pgutils.zip')

load2postgres <- function(inputfilepath,schema,tablename,pk=NULL,header=TRUE,printcopy=TRUE,sheetname="Sheet1",withoids=FALSE,pguser="username",db='databasename',ip='ipaddress',source_file="STDIN",datecol=NULL,nrowscsv=10000,pgpath=c('c:\\pgutils\\psql')){
  if (!require(RODBC)) install.packages('RODBC'); require(RODBC) # for getSqlTypeInfo
  table=paste(schema,".",tablename,sep="")
  
  ext<-substr(inputfilepath,nchar(inputfilepath)-2,nchar(inputfilepath))
  #print(ext)
  
  if (ext=="dbf"){
    require(foreign)
    data<-read.dbf(inputfilepath,as.is=TRUE)
    csvfilename=sub(".dbf",".csv",basename(inputfilepath))
    csvfilename=paste(getwd(),csvfilename,sep="/")
    write.csv(data,csvfilename,row.names=FALSE,na="")
  }
  else if (ext=="csv" || ext=="txt"){
    #or from csv originally
    csvfilename<-inputfilepath
    data<-read.csv(csvfilename,stringsAsFactors=FALSE,header=header,strip.white=TRUE,nrows=nrowscsv)
    names(data)<-gsub("\\.","_",names(data))
    names(data)<-gsub("_+","_",names(data))
  }
  else if (ext=="xls"){
    odbcf<-odbcConnectExcel(inputfilepath)
    data<-sqlFetch(odbcf,sheetname,as.is=TRUE)
    csvfilename=sub(".xls",".csv",basename(inputfilepath))
    csvfilename=paste(getwd(),csvfilename,sep="/")
    write.csv(data,csvfilename,row.names=FALSE,na="")
  }
  else print("Unknown extension")
  
  names(data)<-tolower(names(data))
  
  if (length(pk)>0) {
    if (class(pk) %in% c("integer","numeric")) pk=paste(names(data)[pk],collapse=",")
  }
  
  datatypes<-getSqlTypeInfo("PostgreSQL")
  datatypes["numeric"]<-"numeric"
  
  csvfilename=gsub("\\\\","\\\\\\\\",csvfilename)
  
  text=""
  text=paste(text,"CREATE TABLE ",table," (",sep="")
  columnnames<-names(data)
  
  #################################################################################
  
  if (length(pk)>0) {
    for (n in columnnames) {
      if (length(grep(n, datecol))>0) {
        text=paste(text,"\"",n,"\" date,\n",sep="")
      } else {
        #print(class(data[[n]]))
        if (is.null(class(data[[n]]))) cat("Missing datatype:",class(data[[n]]),"\n")
        text=paste(text,"\"",n,"\" ",datatypes[[class(data[[n]])]],",\n",sep="")
      }
    }
    text=paste(text,"CONSTRAINT \"",table,"_pkey\" PRIMARY KEY (",pk,")\n",sep="")
  }
  
  if (length(pk)==0) {
    for (n in columnnames[1:(length(columnnames)-1)]) {
      if (length(grep(n, datecol))>0) {
        text=paste(text,"\"",n,"\" date,\n",sep="")
      } else {
        #print(class(data[[n]]))
        if (is.null(class(data[[n]]))) cat("Missing datatype:",class(data[[n]]),"\n")
        text=paste(text,"\"",n,"\" ",datatypes[[class(data[[n]])]],",\n",sep="")
      }
    }
    
    n=columnnames[length(columnnames)]
    text=paste(text,"\"",n,"\" ",datatypes[[class(data[[n]])]],sep="")
    #\"
  }
  
  ###############################################################################
  if (withoids) text=paste(text,") WITH (OIDS=TRUE);\n",sep="")
  else text=paste(text,") WITH (OIDS=FALSE);\n",sep="")
  text=paste(text,"ALTER TABLE ",table," OWNER TO ",pguser,";\n",sep="")
  
  
  
  
  if (source_file=="STDIN") {
    if (header) text=paste(text,"COPY ",table," FROM ",source_file," CSV HEADER;\n",sep="")
    else text=paste(text,"COPY ",table," FROM ",source_file," CSV;\n",sep="")
    
    sink("sqlquery.txt")
    cat(text)
    sink()
    
    
    
 
    if(length(grep('linux',sessionInfo()[[1]]$os)) == 1)
     {
      os <- 'linux'
     } else {
      os <- 'windows'
     }
    if (printcopy & os == 'linux')
    {
      cat(paste('ok the CREATE TABLE and COPY statements have been constructed for this file and is in "sqlquery.txt", have a look and see if it is correct\nif it is ok and you have not set your password to be remembered in pgpass then paste this into a cmd prompt\n\n cat sqlquery.txt \"',csvfilename,'\" | \"',pgpath,'\" -h ',ip,' -U ',pguser,' -d ',db,'\n\n\notherwise you can run this directly from R\n\n system(\"cat sqlquery.txt \\"',csvfilename,'\\" | \"',pgpath,'\" -h ',ip,' -U ',pguser,' -d ',db,'\")',sep=''),'\n')
      
      cat(paste("\n\nnow you probably should vaccuum the table\nVACUUM ANALYZE ",table,";\n",sep=""))
    } 
    if (!printcopy & os == 'linux')
    {
     
      system(paste('cat sqlquery.txt \"',csvfilename,'\" | psql -h ',ip,' -U ',pguser,' -d ',db,'',sep=''))
          
    }
    

    if (printcopy & os == 'windows')
    {
      cat(paste('ok the CREATE TABLE and COPY statements have been constructed for this file and is in "sqlquery.txt", have a look and see if it is correct\nif it is ok and you have not set your password to be remembered in pgAdmin then paste this into a cmd prompt\n\n type sqlquery.txt \"',csvfilename,'\" | \"',pgpath,'\" -h ',ip,' -U ',pguser,' -d ',db,'\n\n\notherwise you can run this directly from R\n\n system(\"type sqlquery.txt \\"',csvfilename,'\\" | \"',pgpath,'\" -h ',ip,' -U ',pguser,' -d ',db,'\")',sep=''),'\n')
      
      cat(paste("\n\nnow you probably should vaccuum the table\nVACUUM ANALYZE ",table,";\n",sep=""))
    } 
    if (!printcopy & os == 'windows')
    {
      sink('go.bat')
      cat(paste('type sqlquery.txt \"',csvfilename,'\" | \"',pgpath,'\" -h ',ip,' -U ',pguser,' -d ',db,'',sep=''))
      sink()
      shell('go.bat')
      file.remove('go.bat')
    }
    
    
  }
  
}
