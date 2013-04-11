
################################################################
# name:read_file
read_file(inputfilepath, header=TRUE, sheetname="Sheet1")
{
  if (!require(RODBC)) install.packages('RODBC'); require(RODBC) # for
                                        # getSqlTypeInfo
  if(!require(foreign)) install.packages('foreign'); require(foreign)

  ext<-substr(inputfilepath,nchar(inputfilepath)-2,nchar(inputfilepath))
  #print(ext)

  if (ext=="dbf")
  {
    data<-read.dbf(inputfilepath,as.is=TRUE)
  } else if (ext == "dta") {
    data <- read.dta(inputfilepath)
  } else if (ext=="csv" || ext=="txt") {
    #or from csv originally
    csvfilename<-inputfilepath
    data<-read.csv(csvfilename,stringsAsFactors=FALSE,header=header,strip.white=TRUE)
    names(data)<-gsub("\\.","_",names(data))
    names(data)<-gsub("_+","_",names(data))
  } else if (ext=="xls") {
    odbcf<-odbcConnectExcel(inputfilepath)
    data<-sqlFetch(odbcf,sheetname,as.is=TRUE)
  } else print("Unknown extension")

}
