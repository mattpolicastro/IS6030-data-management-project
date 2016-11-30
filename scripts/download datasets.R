# Get working directory
working_dir <- getwd() 

# Load config values
source(paste0(working_dir, "/config.R"))
# Re-declare the config list to stop lintr from throwing missing object warnings
config <- config

# Load the Socrata API client
library(RSocrata)
# Download permits dataset
permits <- read.socrata(
  "https://data.cincinnati-oh.gov/Thriving-Healthy-Neighborhoods/Cincinnati-Building-Permits/uhjb-xac9",
  app_token = config$socrata_token
)
# Download fire incidents datasets
incidents <- read.socrata(
  "https://data.cincinnati-oh.gov/Safer-Streets/2010-NFIRS-Cincinnati-Fire-Department-Incident-Dat/jg8x-w2hj",
  app_token = config$socrata_token
)

# Function to safely store and symlink latest dataset
store_data <- function(data) {
  # Reference to location in filesystem
  working_dir <- getwd()
  
  # Reference to name of current dataset
  data_name <- substitute(data)
  
  # Reference data file and symlink
  data_symlink <- paste0(working_dir, "/data/", data_name, ".csv")
  data_file <- paste0(working_dir, "/data/", data_name, "_", Sys.Date(), ".csv")
  
  # Write data to file system
  write.csv(data, file = data_file, row.names = FALSE)
  
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

# Store the latest data and update links
store_data(permits)
store_data(incidents)
