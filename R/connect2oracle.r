################################################################
# name:connect2oracle
# make sure you have JDK, if not install the SUN version
#http://blog.i-evaluation.com/2012/12/03/installing-java-sdk-and-jre-bin-files-on-my-ec2-instance/
# then get the JDBC driver from http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-112010-090769.html
# put into /lib
##  did install.packages('rJava') and then
# "R CMD javareconf" as root
connect2oracle <- function(hostip=NA,db=NA, p=NA,
                           driverlocation='/lib/ojdbc6.jar'){
  if(!require(RJDBC)) install.packages('RJDBC'); require(RJDBC)
  drv <- JDBC("oracle.jdbc.driver.OracleDriver",
              '/lib/ojdbc6.jar')
  
  if(is.na(hostip)){
    hostip=readline('enter hostip: ')
  }
  if(is.na(db)){
    db=readline('enter db: ')
  }
  if(is.na(user)){
    user=readline('enter user: ')
  }
  if(is.na(p)){
    pwd=readline(paste('enter password for user ',user, ': ',sep=''))
  } else {
    pwd <- p
  }
  
  ## p <- readline('enter password: ')
  ## h <- readline('enter target ipaddres: ')
  ## d <- readline('enter database name: ')
  ch <- dbConnect(drv,paste("jdbc:oracle:thin:@",hostip,":1521",sep=''),db,pwd)
  return(ch)
}
#ch <- connect2oracle(hostip = '115.146.93.225', db = 'DDIINDEXDB', user = 'ivan_hanigan')
#dir.create('metadata')
#s <- dbGetQuery(ch, "select * from stdydscr where IDNO = 'BOUNDARIES_ELECTORATES'")

