
t################################################################
# name:add_stdydscr

add_stdydscr <- function(idno=NA,titl=NA,abstract=NA,authoring_entity_of_data=NA,
distrbtr='NCEPH data manager',bibliographic_citation=NA,notes='NCEPH Unrestricted', restrctn=NA,datakind='OTHER',ask=F){
if (!require(sqldf)) install.packages('sqldf')
require(sqldf)
if (!require(R2HTML)) install.packages('R2HTML')
require(R2HTML)
  
  elements = c('TITL','IDNO','PRODUCER','PRODDATEDOC','BIBLCITDOC','AUTHENTY','COPYRIGHT','PRODDATESTDY','FUNDAG','DISTRBTR','SERNAME','VERSION','BIBLCITSTDY','TIMEPRD','COLLDATE','GEOGCOVER','GEOGUNIT','ANLYUNIT','UNIVERSE','DATAKIND','CLEANOPS','CONFDEC','SPECPERM','RESTRCTN','NOTES','ABSTRACT')
  
  stdydscr=as.data.frame(matrix(nrow=1,ncol=length(elements), byrow=TRUE))
  names(stdydscr)=elements
  if(is.na(titl)) {titl<- readline('title of study: ')}
  stdydscr$TITL =titl
  if(is.na(idno)) {idno<- readline('ID code of study: ')}
  stdydscr$IDNO =idno
  if(is.na(abstract)) {abstract<- readline('abstract: ')}
  stdydscr$ABSTRACT =abstract
  if(is.na(authoring_entity_of_data)) {authoring_entity_of_data<- readline('authoring_entity_of_data: ')}
  stdydscr$AUTHENTY =authoring_entity_of_data
  # auto
  stdydscr$PRODDATEDOC =Sys.Date()
  
  if(ask==F){
    stdydscr$PRODUCER =''
    
    stdydscr$BIBLCITDOC =''
    stdydscr$COPYRIGHT =''
    stdydscr$PRODDATESTDY =''
    stdydscr$FUNDAG =''
    stdydscr$DISTRBTR = distrbtr
    stdydscr$SERNAME =''
    stdydscr$VERSION =''
    stdydscr$BIBLCITSTDY =bibliographic_citation
    stdydscr$TIMEPRD =''
    stdydscr$COLLDATE =''
    stdydscr$GEOGCOVER =''
    stdydscr$GEOGUNIT =''
    stdydscr$ANLYUNIT =''
    stdydscr$UNIVERSE =''
    stdydscr$DATAKIND =datakind
    stdydscr$CLEANOPS =''
    stdydscr$CONFDEC =''
    stdydscr$SPECPERM =''
    stdydscr$RESTRCTN =restrctn
    stdydscr$NOTES =notes
    
  } else {
    for(i in c(7:(length(elements)-1))){
      element=elements[i]
      stdydscr[1,i]=readline(paste("enter descriptions for the ",element,": "))
    }
  }
  stdydscr$PRODDATESTDY <- format(as.Date( substr(stdydscr$PRODDATESTDY,1,10),'%Y-%m-%d'),"%d/%b/%Y")
  stdydscr$PRODDATEDOC <- format(as.Date( substr(stdydscr$PRODDATEDOC,1,10),'%Y-%m-%d'),"%d/%b/%Y")



  # TASK add a caveat that if NOTES is null then NCEPH Unrestricted
  return(stdydscr)
}
