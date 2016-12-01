# Load config values and re-declare object to stop lintr warnings
source(paste0(getwd(), "/config.R"))
config <- config

# Load utility functions and re-declare for lintr
source(paste0(getwd(), "/scripts/util_save_data.R"))
filesystem_save <- filesystem_save
database_save <- database_save

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

# Save data
filesystem_save(permits)
filesystem_save(incidents)

# Insert data into database
database_save(permits)
database_save(incidents)
