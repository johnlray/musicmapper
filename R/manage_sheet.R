library(tidyverse)
library(googlesheets4)
library(ggmap)

# This code takes a list of locations and geocodes them
# You will need a Google API key to run this code.
# You can tell if you do if running this code...
# has_google_key()
# ...evalutes to `TRUE`

# Check on the status of your geocoding credentials
getOption("ggmap")

# Load the spreadsheet
df <- read_sheet("https://docs.google.com/spreadsheets/d/1XZ6n-2_RhQnu_ZwuUSUIhLIezA5y0J9MTPd0qJ1Alc0")

# Get the unique set of locations to geocode
locs <- df %>%
  select(city) %>%
  distinct() %>%
  mutate_geocode(location = city, output = "latlon")

df <- left_join(df, locs)

# Update the google sheet with a new geocoded/'full' dataset
sheets_write(df, ss = "https://docs.google.com/spreadsheets/d/1XZ6n-2_RhQnu_ZwuUSUIhLIezA5y0J9MTPd0qJ1Alc0", sheet = "full")
