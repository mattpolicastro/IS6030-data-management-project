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

# Declare data file locations
permits_file <- paste0(working_dir, "/data/permits")
incidents_file <- paste0(working_dir, "/data/incidents")
# Declare data file locations with datetime
permits_file_latest <- paste0(permits_file, "_", Sys.time())
incidents_file_latest <- paste0(incidents_file, "_", Sys.time())

# Write out the downloaded datasets
write.csv(permits, file = permits_file_latest, row.names = FALSE)
write.csv(incidents, file = incidents_file_latest, row.names = FALSE)

# Function to safely store and symlink latest dataset
store_data <- function(canonical, latest) {
  if (file.exists(latest)) {
    if (file.exists(canonical)) {
      file.remove(canonical)
    }
    file.symlink(latest, canonical)
  } else {
    message(paste("Unable to find most recent version of data in", latest))
  }
}

# Store the latest data and update links
store_data(permits_file, permits_file_latest)
store_data(incidents_file, incidents_file_latest)
