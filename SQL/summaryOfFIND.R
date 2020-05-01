# instantiates the driver object
drv <- DBI::dbDriver("PostgreSQL")

# creates and opens a connection to the database implemented by the driver drv.
# Connection string should be specified with parameters like user, password, 
# dbname, host, port, tty and options
con <- DBI::dbConnect(drv, host="localhost", 
                      port="5432", dbname="FIND", 
                      user="postgres", password="albamia") 

# provides List of connections handled by the driver
DBI::dbListConnections(drv)

# dbGetInfo(dbObject, ...) and summary(dbObject) returns information 
# about the dbObject (driver, connection or resultSet)
DBI::dbGetInfo(drv)
summary(con)

# List of all tables in DB
DBI::dbListTables(con)

###
# all values and all site
###
# Run an SQL statement by creating first a resultSet object.
# Submits one statement to the database
DBI::dbGetQuery(con, "SET NAMES 'utf8'")
queryValue <- DBI::dbSendQuery(conn = con, statement = paste(
"SELECT 
  MIN (s.\"Sample_Data\"),
  MAX (s.\"Sample_Data\"),
  COUNT (s.\"ITT\") AS \"n of samples of fish\",
  /*COUNT (s.\"ZOO) AS \"n of samples of \",
  COUNT (s.\"PHY) AS \"n of samples of \",
  COUNT (s.\"COM) AS \"n of samples of \",
  COUNT (s.\"BEN) AS \"n of samples of \",
  COUNT (s.\"CHI) AS \"n of samples of \",
  COUNT (s.\"MACRO) AS \"n of samples of \",
  COUNT (s.\"MICRO) AS \"n of samples of \",*/
  l.\"Lake_Name\"
FROM
  public.\"COM_Samples\" AS s
  INNER JOIN public.\"COM_Lakes\" AS l ON (s.\"ID_Lake\" = l.\"ID_Lake\")
WHERE
  s.\"ITT\" = 1
GROUP BY
  l.\"Lake_Name\""
));
tblValue <- DBI::fetch(queryValue, n = -1)

