
#require(testthat)
source("../R/pgListTables.r")
source("../R/connect2postgres2.r")
source("../R/connect2postgres.r")
source("../R/get_pgpass.r")
source("../R/getPassword.r")
source("../R/get_passwordTable.r")
source("../R/LinuxOperatingSystem.r")

ch <- connect2postgres2("ewedb")
test_that("lists postgis table", {
  expect_that(nrow(pgListTables(conn=ch, schema="public",
                                pattern="spatial_ref_s")) == 1,
               is_true())
   expect_that(nrow(pgListTables(conn=ch, schema='public',
                                 pattern='elmoreJames')) == 0,
               is_true())
})


# dev tests
##  tbls <- pgListTables(conn=ch, schema='public', pattern='spatial_ref_sys')
##  nrow(tbls) == 1
## #
##  tbls <- pgListTables(conn=ch, schema='public', pattern='elmoreJames')
##  nrow(tbls)
# tbls
# pgListTables(conn=ch, schema='public', pattern='dbsize')
# tables <- dbGetQuery(ch, 'select   c.relname, nspname, c.relkind
#                        FROM pg_catalog.pg_class c
#                        LEFT JOIN pg_catalog.pg_namespace n
#                      ON n.oid = c.relnamespace
#                      where c.relkind IN (\'r\',\'\', \'v\') ')
#
# table(tables$relkind)
# # S     c     i     r     t     v
# # 20509    11 61649 20609 20527   109
