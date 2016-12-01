# Function to safely store and link latest dataset
filesystem_save <- function(data) {
  # Reference to location in filesystem
  working_dir <- getwd()
  
  # Reference to name of current dataset
  data_name <- substitute(data)
  
  # Reference data file and symlink
  data_symlink <- paste0(working_dir, "/data/", data_name, ".csv")
  data_file <- paste0(working_dir, "/data/", data_name, "_", Sys.Date(), ".csv")
  
  # Write data to file system - set NA/missing values to "" or SQL imports will
  # error out
  write.csv(data, file = data_file, na = "", row.names = FALSE)
  
  # Safety check and symlink latest file
  if (file.exists(data_file)) {
    # If the symlink exists, remove it
    if (file.exists(data_symlink)) {
      file.remove(data_symlink)
    }
    # Symlink the latest data 
    file.link(data_file, data_symlink)
  } else {
    message(paste("Unable to find most recent version of data in", latest_csv))
  }
}

# Function to safely save full dataset to database
database_save <- function(data) {
  # Open database connection, presuming Windows Domain Auth is configured
  sql_server <- RODBC::odbcConnect("SQL Server")
  
  # Reference name of current dataset
  data_name <- as.character(substitute(data))
  
  
  # Strip out Date types as they throw errors with the ODBC driver during insert
  for (i in colnames(data)) {
    if (class(data[,i])[1] == ('POSIXct')) {
      data[,i] <- as.character(data[,i])
    }
  }
  
  # Check if table is in database
  if (nrow(RODBC::sqlTables(sql_server, tableName = data_name, errors = F)) == 1) {
    message("Deleting old table...")
    RODBC::sqlDrop(sql_server, data_name, errors = F)
  }
  
  # Save data to database in new table including new Primary Key
  message("Creating new table...")
  RODBC::sqlSave(sql_server, data, tablename = data_name, addPK = T)
  
  # Close database connection
  RODBC::odbcClose(sql_server)
}
