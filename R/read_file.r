
################################################################
# name:read_file

read_file <- function(inputfilepath, header=TRUE, sheetname="Sheet1", sanitise_names = TRUE)
{

  filename <- unlist(
                     strsplit(inputfilepath,"/")
                     )[length(unlist(strsplit(inputfilepath,"/")))]
  filename_split <- strsplit(filename, "\\.")[[1]]
  ext <- filename_split[length(filename_split)]
  # print(ext)

  if (ext=="dbf")
  {
    data<-read.dbf(inputfilepath,as.is=TRUE)
  } else if (ext == "dta") {
    data <- read.dta(inputfilepath)
  } else if (ext=="csv" || ext=="txt") {
    #or from csv originally
    csvfilename<-inputfilepath
    data<-read.csv(csvfilename,stringsAsFactors=FALSE,header=header,strip.white=TRUE)
  } else if (ext=="xls" || ext == "xlsx") {
    wb <- loadWorkbook(inputfilepath)
    data <- readWorksheet(wb, sheet = "Sheet1")
  } eles if (ext == "shp") {
    layer <- gsub(paste(".", ext, sep = ""), "", filename)
    datadir <- gsub(filename, "", inputfilepath)
    workdir <- getwd()
    setwd(datadir)
    data <- readOGR(filename, layer)
    setwd(workdir)
  } else print("Unknown extension")

  if(sanitise_names)
    {
      names(data)<-gsub("\\.","_",names(data))
      names(data)<-gsub("_+","_",names(data))
    }

  return(data)
}
