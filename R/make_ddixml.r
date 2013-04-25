
################################################################
# name:make_ddixml
make_ddixml <- function(s,f,d, writeXML = F){
if (!require(sqldf)) install.packages('sqldf')
require(sqldf)

abbreviation=toupper(f$IDNO)
print(abbreviation) 
# get study data
stdyDscr=s
head(t(stdyDscr))
tail(t(stdyDscr))

# get othrstdymat
# othrstdymat <- sqlQuery(ch,
# sprintf("
# select t1.titl, t2.*
# from stdyDscr t1
# join othrstdymat t2
# on t1.idno=t2.idno
# where t1.idno='%s'
# ",abbreviation)
# ,stringsAsFactor=F)

# if(nrow(othrstdymat)>0){
# stdyDscr$ABSTRACT <- paste(stdyDscr$ABSTRACT,
# '\n\nRELATED MATERIAL:\n',
# paste(othrstdymat$RELPUBL[!is.na(othrstdymat$RELPUBL)],collapse='\n ',sep=''),
# '\n\nRELATED NCEPH STUDIES:\n',
# paste(othrstdymat$RELSTDYID[!is.na(othrstdymat$RELSTDYID)],collapse='\n ',sep='')
# ,sep='')
# }
# cat(stdyDscr$ABSTRACT)

# TASK if files then 'http://alliance.anu.edu.au/access/content/group/bf77d6fc-d1e1-401c-806a-25fbe06a82d0/ddiindex-nceph/',tolower(abbreviation),'_',fileid,'.html'
# CUT from xml
#paste("\nMETADATA DOCUMENTS:
#http://alliance.anu.edu.au/access/content/group/bf77d6fc-d1e1-401c-806a-25fbe06a82d0/ddiindex-nceph/",fileDscrJ$idno,'_',fileDscrJ$fileid,'.html (and xml)',sep=''),

# get file data
fileDscr=f

head(fileDscr)
fileDscr[,1:4]


if(nrow(fileDscr)==0){
fileDscr=data.frame(t(c(1,abbreviation,stdyDscr$TITL,'Metadata','','','','','','NCEPH','NCEPH Restricted','','','','')),stringsAsFactors =F)
names(fileDscr) = c('FILEID','IDNO','FILENAME','FILETYPE','PROCSTAT','SPECPERMFILE','DATEARCHIVED','DATEDESTROY','FILEDSCR','FILELOCATION','NOTES','REQID','PUBLISHDDI','BACKUPVALID','DATEBACKUPVALID')
} 
# get variable details

#for(j in 1:nrow(fileDscr)){
j=1
fileDscrJ= fileDscr[j,]
names(fileDscrJ)=toupper(names(fileDscrJ))
filej=fileDscr[j,1]
filej
dataDscr=d
head(dataDscr)
dataDscr$PKEY <- seq(1:nrow(dataDscr))
dataDscr<- dataDscr[,c(5,1:4)]
#V1="V1"
#vardesc1="variable description stuff"
#varlabels1="theNameOfTheVariable"
if(nrow(dataDscr)==0) {
variablesList=paste("<var ID='V1' name ='",fileDscrJ$FILENAME,"'>
<location></location>
<labl>
<![CDATA[
",fileDscrJ$NOTES,"
]]>
</labl>
<qstn></qstn>
<qstnLit></qstnLit>
<invalrng></invalrng>
<range></range>
<item></item>
<notes></notes>
<universe></universe>
<sumStat></sumStat>
<txt></txt>
<catgryGrp></catgryGrp>
<labl></labl>
<catStat></catStat>
<catgry></catgry>
<catValu></catValu>
<labl></labl>
<txt></txt>
<catStat></catStat>
<concept></concept>
<derivation></derivation>
<drvdesc></drvdesc>
<varFormat></varFormat>
<notes>
<![CDATA[
",fileDscrJ$NOTES,"             
]]>
</notes>
</var>",sep=""
)
} else {

for(i in 1:nrow(dataDscr)){

#i=2
if (i == 1) {
variablesList=paste("<var ID='V",i,"' name ='",as.character(dataDscr[i,'LABL']),"'>
<location></location>
<labl>
<![CDATA[
",dataDscr[i,'NOTES'],"
]]>
</labl>
<qstn></qstn>
<qstnLit></qstnLit>
<invalrng></invalrng>
<range></range>
<item></item>
<notes></notes>
<universe></universe>
<sumStat></sumStat>
<txt></txt>
<catgryGrp></catgryGrp>
<labl></labl>
<catStat></catStat>
<catgry></catgry>
<catValu></catValu>
<labl></labl>
<txt></txt>
<catStat></catStat>
<concept></concept>
<derivation></derivation>
<drvdesc></drvdesc>
<varFormat></varFormat>
<notes>
<![CDATA[
",dataDscr[i,'NOTES'],"
]]>
</notes>
</var>",sep=""
)
} 
else {
variablesList=rbind(variablesList,
paste("<var ID='V",i,"' name ='",dataDscr[i,'LABL'],"'>
<location></location>
<labl>
<![CDATA[
",dataDscr[i,'NOTES'],"
]]>
</labl>
<qstn></qstn>
<qstnLit></qstnLit>
<invalrng></invalrng>
<range></range>
<item></item>
<notes></notes>
<universe></universe>
<sumStat></sumStat>
<txt></txt>
<catgryGrp></catgryGrp>
<labl></labl>
<catStat></catStat>
<catgry></catgry>
<catValu></catValu>
<labl></labl>
<txt></txt>
<catStat></catStat>
<concept></concept>
<derivation></derivation>
<drvdesc></drvdesc>
<varFormat></varFormat>
<notes>
<![CDATA[
",dataDscr[i,'NOTES'],"
]]>
</notes>
</var>",sep=""))
}
}
cat(variablesList)
}

# get keywords
keywords=abbreviation

keywords=c(keywords,
unlist(strsplit(dataDscr$LABL,"_")),
unlist(strsplit(fileDscrJ$FILENAME,"_"))
)

keywords=data.frame(toupper(keywords))
names(keywords)='keywords'
keywords=sqldf('select distinct keywords from keywords',drv='SQLite')

for(i in 1:nrow(keywords)){
#i=2
if (i == 1) {
keywordslist=paste("<keyword>
<![CDATA[  
",keywords[i,1],"
]]>
</keyword>",sep="")
} else {
keywordslist=rbind(keywordslist,
paste("<keyword>
<![CDATA[  
",keywords[i,1],"
]]>
</keyword>",sep="")
)
}
}
cat(keywordslist)

#################################################################################
# save to an xml

names(stdyDscr)=tolower(names(stdyDscr))
attach(stdyDscr)
names(fileDscr)=tolower(names(fileDscr))
names(fileDscrJ)=tolower(names(fileDscrJ))
attach(fileDscrJ)




xml=paste("
<codeBook version=\"1.2.2\" ID=\"",tolower(abbreviation),"_",fileDscrJ$fileid,"\">
<docDscr>
<citation>
<titlStmt>
<titl>
<![CDATA[  
",paste(toupper(abbreviation),filename,sep='_'),"
]]> 
</titl>
<IDNo>
<![CDATA[  
",tolower(abbreviation),"_",fileDscrJ$fileid,"
]]> 
</IDNo>
</titlStmt>
<prodStmt>
<producer>
<![CDATA[  
",producer,"
]]>
</producer>
<copyright>
<![CDATA[  
",copyright,"
]]>
</copyright>
<prodDate date='",as.Date(proddatedoc,'%d/%M/%Y'),"'>'",as.Date(proddatedoc,'%d/%M/%Y'),"'
</prodDate>
<software></software>
</prodStmt>
<verStmt>
<version></version>
<notes></notes>
</verStmt>
<biblCit>
<![CDATA[  
",biblcitdoc,"
]]>
</biblCit>
</citation>
<notes></notes>
</docDscr>
<stdyDscr >
<citation >
<titlStmt>
<titl>
<![CDATA[  
",paste(toupper(abbreviation),filename,sep='_'),"
]]>
</titl>
<IDNo>
<![CDATA[  
",tolower(abbreviation),"_",fileDscrJ$fileid,"
]]>
</IDNo>
</titlStmt>
<rspStmt>
<AuthEnty>
<![CDATA[  
",authenty,"
]]>
</AuthEnty>
<othId></othId>
</rspStmt>
<prodStmt>
<producer></producer>
<copyright>
<![CDATA[  
",copyright,"
]]>
</copyright>
<prodDate>
<![CDATA[  
",proddatestdy,"
]]>
</prodDate>
<fundAg>
<![CDATA[  
",fundag,"
]]>          
</fundAg>
</prodStmt>
<distStmt>
<distrbtr>
<![CDATA[  
",distrbtr,"
]]>  
</distrbtr>
<contact>
<![CDATA[  
",distrbtr,"
]]>  
</contact>
<distDate></distDate>
</distStmt>
<serStmt>
<serName>
<![CDATA[  
",sername,"
]]>  
</serName>
</serStmt>
<verStmt>
<version>
<![CDATA[  
",version,"
]]>  
</version>
<notes></notes>
</verStmt>
<biblCit>
<![CDATA[  
",biblcitstdy,"
]]>  
</biblCit>
</citation >
<stdyInfo>
<subject>
",paste(t(keywordslist),collapse="\n"),"
<topcClas>
<![CDATA[ 
",stdyDscr$notes," 
]]> 
</topcClas>
<topcClas>
<![CDATA[  
",titl,"
]]> 
</topcClas>
</subject>
<abstract>
<![CDATA[
",

paste("\n\nSTUDY TITLE:\n",titl,
"\n\nFILE DESCRIPTION:\n",fileDscr$filetype[j],"\n",fileDscr$filedscr[j],"\n",fileDscr$notes[j],
"\n\nSTUDY DESCRIPTION:\n",abstract,sep="",collapse="\n"),

"
]]>
</abstract>
<sumDscr>
<timePrd>
<![CDATA[
",timeprd,"           
]]> 
</timePrd>
<collDate>
<![CDATA[
",colldate," 
]]>
</collDate>
<nation></nation>
<geogCover>
<![CDATA[
",geogcover,"        
]]>
</geogCover>
<geogUnit>
<![CDATA[
",geogunit," 
]]> 
</geogUnit>
<anlyUnit>
<![CDATA[
",anlyunit,"
]]> 
</anlyUnit>
<universe>
<![CDATA[
",universe,"
]]> 
</universe>
<dataKind>
<![CDATA[
",datakind,"
]]>
</dataKind>
</sumDscr>
<notes></notes>
</stdyInfo>
<method>
<dataColl>
<timeMeth></timeMeth>
<dataCollector></dataCollector>
<sampProc></sampProc>
<collMode></collMode>
<sources></sources>
<weight></weight>
<cleanOps>
<![CDATA[
",cleanops,"
]]>
</cleanOps>
</dataColl>
<notes></notes>
</method>
<dataAccs>
<setAvail>
<collSize></collSize>
<fileQnty></fileQnty>
</setAvail>
<useStmt>
<confDec>
<![CDATA[
",confdec,"
]]>
</confDec>
<specPerm>
<![CDATA[
",paste("STUDY PERMISSIONS:\n",specperm,"\nFILE PERMISSIONS:\n",fileDscrJ$specpermfile,sep=""),"
]]>
</specPerm>
<restrctn></restrctn>
</useStmt>
</dataAccs>
<notes>
<![CDATA[
",notes," 
]]>
</notes>
</stdyDscr >
<fileDscr>
<fileTxt>
<fileName>
<![CDATA[
",paste(tolower(abbreviation),filename,sep='_'),"
]]>
</fileName>
<dimensns>
<caseQnty></caseQnty>
<varQnty></varQnty>
<logRecL></logRecL>
<recPrCas></recPrCas>
</dimensns>
<fileType>
<![CDATA[
",filetype,"
]]>
</fileType>
<ProcStat>
<![CDATA[
",'processing description suppressed',"
]]>
</ProcStat>
</fileTxt>
<notes>
<![CDATA[
",notes," 
]]>
</notes>
</fileDscr>
<dataDscr>
<varGrp></varGrp>
<labl></labl>
<notes></notes>
",paste(t(variablesList),collapse="\n"),"
</dataDscr>
</codeBook>
",sep="")
#    ",paste(t(othermatlist),collapse="\n"),"
detach(stdyDscr)
detach(fileDscrJ)

#  cat(xml)
if(writeXML)
{
outdir <- getwd()
write.table(xml,sprintf("%s/%s%s%s.xml",outdir,tolower(abbreviation),"_",fileDscrJ$fileid),row.names=F,col.names=F,quote=F)
} else {
return(xml)
}  
}
