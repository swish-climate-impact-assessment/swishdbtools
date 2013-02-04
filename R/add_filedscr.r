
################################################################
# name:add_filedscr
add_filedscr <- function(fileid=NA,idno=NA,filename=NA,notes='NCEPH_Unrestricted',filelocation=NA,file_description='',ask=F){
  if (!require(sqldf)) install.packages('sqldf')
  require(sqldf)
  if (!require(R2HTML)) install.packages('R2HTML')
  require(R2HTML)
    
  elements = c('IDNO','FILENAME','FILETYPE','PROCSTAT','SPECPERMFILE','DATEARCHIVED','DATEDESTROY','FILEDSCR','NOTES','REQID','PUBLISHDDI','BACKUPVALID','DATEBACKUPVALID','CHECKED','BACKUPLOCATION')
  filedscr=as.data.frame(matrix(nrow=1,ncol=length(elements), byrow=TRUE))
  names(filedscr)=elements
  stopifnot(!is.na(idno)) 
  filedscr$IDNO =idno
  if(is.na(fileid)) {fileid<- readline('fileid, one number for each file in the study: ')}
  filedscr$FILEID =fileid
  if(is.na(filename)) {filename<- readline('filename: ')}
  filedscr$FILENAME =filename
  if(is.na(notes)) {notes<- readline('notes: ')}
  filedscr$NOTES =notes
#  if(is.na(filelocation)) {filelocation <- getwd()}
  if(is.na(filelocation)) {filelocation <- readline('file_location: ')}
  filedscr$FILELOCATION =filelocation
  if(is.na(file_description)) {file_description<- readline('file_description: ')}
  filedscr$FILEDSCR=file_description
  
  if(ask==F){
    filedscr$FILELOCATION = getwd()
    filedscr$FILETYPE =''
    filedscr$PROCSTAT =''
    filedscr$SPECPERMFILE =''
    filedscr$DATEARCHIVED =''
    filedscr$DATEDESTROY =''
    filedscr$REQID =''
    filedscr$PUBLISHDDI =''
    filedscr$BACKUPVALID =''
    filedscr$DATEBACKUPVALID =''
    filedscr$CHECKED =''
    filedscr$BACKUPLOCATION =''
  } else {
    for(i in 3:length(elements)){
      element=elements[i]
      filedscr[1,i]=readline(paste("enter descriptions for the ",element,": "))
    }
  }
  
  return(filedscr)
}
