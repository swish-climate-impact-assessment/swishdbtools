
################################################################
# name:sql_tsfill
# # Example use FillCategoryTimeSeries
# FillTest.csv is a file containing incomplete values for table with columns factorA, factorB, and value
source("../R/sql_tsfill.r")
require(sqldf)
#sparseTable <- read.csv("../FillTest.csv")
sparseTable <- "factorA, factorB, value
A, X, 1
A, Z, 2
B, Y, 3
"
tableIn <- read.csv(textConnection(sparseTable))
variable1 <- as.data.frame(toupper(letters[1:4]))
names(variable1) <- 'factorA'

variable2 <- as.data.frame(c(1:3))
names(variable2) <- 'factorB'

filledTable <- sql_tsfill(tableIn, "value", -1, variable1, variable2)
#filledTable

correct <- "factorA, factorB, value
A,       1,    -1
A,       2,    -1
A,       3,    -1
B,       1,    -1
B,       2,    -1
B,       3,    -1
C,       1,    -1
C,       2,    -1
C,       3,    -1
D,       1,    -1
D,       2,    -1
D,       3,    -1
"
correct <- read.csv(textConnection(correct), stringsAsFactors = FALSE)
#str(correct)
#str(filledTable)
test_that('tsfill returns correct',
          {
            expect_that(identical(filledTable, correct), is_true())
          }
)
