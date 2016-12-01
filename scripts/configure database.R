library(sqldf)
library(RODBC)

working_dir <- getwd()

permits_file <- paste0(working_dir, "/data/permits.csv")

# Retrieved column headers from the saved dataset
permits_columns <- colnames(read.csv(permits_file))

# Manually declared data types for each column
column_types <- "PERMITNUM varchar, DESCRIPTION varchar, APPLIEDDATE date, ISSUEDDATE date, COMPLETEDDATE date, ORIGINALADDRESS1 varchar, ORIGINALCITY varchar, ORIGINALSTATE varchar, ORIGINALZIP varchar, JURISDICTION varchar, PERMITCLASS varchar, PERMITCLASSMAPPED varchar, STATUSCURRENT varchar, STATUSCURRENTMAPPED varchar, WORKCLASS varchar, WORKCLASSMAPPED varchar, PERMITTYPE varchar, PERMITTYPEMAPPED varchar, COMPANYNAME varchar, TOTALSQFT varchar, ESTPROJECTCOSTDEC varchar, ESTPROJECTCOSTTEXT varchar, UNITS varchar, PIN varchar, PROPOSEDUSE varchar, EXPIRESDATE date, COISSUEDDATE date, FEE money, LINK varchar, LATITUDE decimal, LONGITUDE decimal"

# Construct the CREATE TABLE statement
query_create_table <- paste0("CREATE TABLE permits(", column_types ,");")
sqldf(query_create_table, dbname = "permitsincidents", user = "mattpolicastro")


query_postgres_bulk_insert <- paste0(
  "COPY permits(", paste(permits_columns, collapse = ", "), ") ",
  "FROM '", permits_file, "' DELIMITER ',' CSV HEADER;"
)
sqldf(query_postgres_bulk_insert, dbname = "permitsincidents", user = "mattpolicastro")
