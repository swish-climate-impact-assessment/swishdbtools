
################################################################
# name:add_datadscr
add_datadscr <- function(data_frame, fileid = NA,notes=NA,specperm=F,ask=F){


  labls=names(data_frame)
  datadscr=as.data.frame(matrix(nrow=length(labls),ncol=4, byrow=TRUE))
  names(datadscr)=c('LABL','NOTES','SPECPERMVAR', 'FILEID')
  datadscr$LABL=labls
  if( !is.na(notes) ){ stopifnot(length(notes) == length(labls))}
  
  if(!is.na(notes[1])) {
    datadscr$NOTES=notes
  } else if(ask==F){
    datadscr$NOTES=rep('',length(labls))
  } else {
    for(i in 1:length(labls) ){
      #if element is null then
      labl=labls[i]
      datadscr[i,1]=labl
      datadscr[i,2]=readline(paste("enter descriptions for the ",labl,": "))
      if(specperm==T) datadscr[i,3]=readline(paste("special permissions for ",labl,": "))
    }
  }
  datadscr$FILEID=fileid
  # cat(paste("write.table(f,'metadata/{study}_ddi_filedscr.csv',sep=',',row.names=F)
  #           # OR
  #           write.table(f,'metadata/{study}_ddi_filedscr.csv',sep=',',row.names=F, append=T, col.names=F)
  #           ",sep=''))

  return(datadscr)
  
}
