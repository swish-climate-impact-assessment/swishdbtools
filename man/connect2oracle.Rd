\name{connect2oracle}
\alias{connect2oracle}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
connect to a oracle db
}
\description{
connect to a oracle db
}
\usage{
connect2oracle(hostip=NA,db=NA,user=NA, p=NA, driverlocation='/lib/ojdbc6.jar')
}
%- maybe also 'usage' for other objects documented here.
\arguments{

  \item{hostip}{
%%     ~~Describe \code{hostip} here~~
}
  \item{db}{
%%     ~~Describe \code{db} here~~
}
  \item{user}{
%%     ~~Describe \code{user} here~~
}
  \item{p}{
%%     ~~Describe \code{p} here~~
}
  \item{driverlocation}{
defaults to linux location.  not tested on windoze.
}

}

\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
ivanhanigan
}
\note{
make sure you have JDK, if not install the SUN version
http://blog.i-evaluation.com/2012/12/03/installing-java-sdk-and-jre-bin-files-on-my-ec2-instance/
then get the JDBC driver from http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-112010-090769.html
put into /lib
did install.packages('rJava') and then
"R CMD javareconf" as root
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# example using the SWISH Extreme Weather Eventds DataBase (EWEDB).
# NB only powerusers will know the password.
ch <- connect2oracle(hostip = '115.146.93.225', db = 'DDIINDEXDB')
stdydscr <- dbGetQuery(ch, "select * from stdydscr where IDNO = 'EWEDB'")
t(stdydscr)



}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
