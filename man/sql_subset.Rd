
\name{sql_subset}
\alias{sql_subset}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
sql_subset
}
\description{
Constructs an SQL query for a postgres database. Modelled on the base R function 'subset'.
}
\usage{
sql_subset(conn, x, subset, select, schema, limit, eval)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{conn}{
%%     ~~Describe \code{remote} here~~
database connection
}
 \item{x}{
%%     ~~Describe \code{remote} here~~
the table name
}
 \item{subset}{
%%     ~~Describe \code{remote} here~~
the SQL 'where' statement
}
 \item{select}{
%%     ~~Describe \code{remote} here~~
which variables to include
}
 \item{schema}{
%%     ~~Describe \code{remote} here~~
the schema that has the table in it
}
 \item{limit}{
%%     ~~Describe \code{remote} here~~
limit, often useful for debugging
}
 \item{eval}{
%%     ~~Describe \code{remote} here~~
evaluate the query on the database?
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
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
ch <- connect2postgres('115.146.84.135', db='ewedb',
                       user='gislibrary', p='gislibrary')
sql <- sql_subset(conn=ch, x='spatial_ref_sys',
                  subset = "srid = 4283", select='srid, srtext',
                  limit = 2, eval = T)
  
  
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
